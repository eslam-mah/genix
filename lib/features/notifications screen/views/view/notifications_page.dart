import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/widgets/customappbar.dart';

import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';

import 'package:genix/core/widgets/customglowingbutton.dart';

import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/notifications%20screen/data/models/notifications_model.dart';
import 'package:genix/features/notifications%20screen/view%20model/get%20all%20notifications/get_all_notifications_cubit.dart';
import 'package:genix/features/notifications%20screen/views/widgets/notification_item.dart';
import 'package:genix/features/notifications%20screen/views/widgets/notification_shimmer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/localization/all_app_strings.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
  });
  static const route = '/notifications';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;
  final PagingController<int, NotificationsModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  late GetAllNotificationsCubit getNotificationsCubit;
  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;
    getNotificationsCubit = BlocProvider.of<GetAllNotificationsCubit>(context);
    _pagingController.addPageRequestListener((page) {
      print('**********PAGEKEY************ $page');
      getNotificationsCubit.getAllNotifications(page: page);
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  Future<void> _fetchPage(List<NotificationsModel> items) async {
    try {
      final newItems = items;
      final isLastPage = newItems.length < 25;

      if (_nextPageKey == 1) {
        _pagingController.itemList?.clear();
      }

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _nextPageKey = _nextPageKey + 1;
        _pagingController.appendPage(newItems, _nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  RefreshIndicator _notificationPaginationList() {
    return RefreshIndicator(
      color: AppColors.kPrimaryColor,
      onRefresh: () => Future.sync(
        () {
          setState(() {
            _nextPageKey = 1;
          });
          _pagingController.refresh();
        },
      ),
      child: PagedListView<int, NotificationsModel>(
        padding: EdgeInsets.zero,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<NotificationsModel>(
            animateTransitions: true,
            firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                  onTryAgain: () => _pagingController.refresh(),
                ),
            firstPageProgressIndicatorBuilder: (_) => NotificationShimmer(
                  isNightModeEnabled: isNightModeEnabled,
                ),
            newPageProgressIndicatorBuilder: (_) => NewPageProgressIndicator(),
            noItemsFoundIndicatorBuilder: (_) => NoItemsFoundIndicator(),
            itemBuilder: (context, item, index) {
              print('++++++++++ $index');
              return NotificationItem(
                notification: item,
                isNightMode: isNightModeEnabled,
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetAllNotificationsCubit, GetAllNotificationsState>(
          listener: (context, state) {
            if (state is GetAllNotificationsSuccess) {
              print(
                  'LENGTH All:: ${state.notifications.data.collection.length}');
              print('RESPONSE:: ${state.notifications.data.collection}');
              _fetchPage(state.notifications.data.collection);
            }
          },
        ),
        BlocListener<ThemeCubit, ThemeState>(
          listener: (context, state) {
            final isNightMode = state == ThemeState.dark;
            handleNightModeChanged(isNightMode);
          },
        ),
        // BlocListener<UpdateNotificationCubit, UpdateNotificationState>(
        //   listener: (context, updateState) {
        //     if (updateState is UpdateNotificationSuccess) {
        //       final int? index =
        //           _pagingController.itemList?.indexWhere((oldPost) {
        //         return (oldPost.collection.first.id ==
        //             updateState.notification.collection.first.id);
        //       });
        //       if (index != null && index >= 0) {
        //         _pagingController.itemList?[index] = updateState.notification;
        //         setState(() {});
        //       }
        //     }
        //   },
        // )
      ],
      child: Scaffold(
        backgroundColor: ThemeCubit().state == ThemeState.dark
            ? DarkModeColors.kBackGroundDark
            : Colors.white,
        key: _scaffoldKey,
        bottomNavigationBar: SafeArea(
            child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const CustomBottomAppBar(
              notificationsEnabled: false,
            ),
            Positioned(
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                  child: CustomGlowingButton(isSelected: isSelected),
                ))
          ],
        )),
        appBar: AppBar(
          toolbarHeight: 45.h,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.barsStaggered,
                size: 18.sp,
              ), // Custom icon
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer(); // Open the drawer
              },
            ),
          ],
          elevation: 0,
          title: const CustomAppBar(),
        ),
        endDrawer: CustomDrawerWidget(
          isNightMode: isNightModeEnabled,
        ),
        body: isSelected
            ? const GlowingButtonBody()
            : Column(
                children: [
                   CustomHeaderWidget(text:'${AppStrings.notifications.getString(context)}'),
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.only(left: 13.w, right: 13.w, top: 10.h),
                    child: _notificationPaginationList(),
                  )),
                ],
              ),
      ),
    );
  }
}
