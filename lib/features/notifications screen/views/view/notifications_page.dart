import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/widgets/customappbar.dart';

import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';

import 'package:genix/core/widgets/customglowingbutton.dart';

import 'package:genix/core/widgets/glowingbuttonbody.dart';
import 'package:genix/features/notifications%20screen/data/models/notifications_model.dart';
import 'package:genix/features/notifications%20screen/view%20model/get%20all%20notifications/get_all_notifications_cubit.dart';
import 'package:genix/features/notifications%20screen/view%20model/update%20notification/update_notification_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

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
      getNotificationsCubit.getAllNotifications();
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  Future<void> _fetchPage(List<NotificationsModel> notifications) async {
    try {
      final newItems = notifications;
      print('fetch:: ${newItems.length}');
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _nextPageKey = _nextPageKey + 1;
        _pagingController.appendPage(newItems, _nextPageKey);
      }
    } catch (error) {
      print('Pagination error: ${error.toString()}');
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
            firstPageProgressIndicatorBuilder: (_) =>
                FirstPageProgressIndicator(),
            newPageProgressIndicatorBuilder: (_) => NewPageProgressIndicator(),
            noItemsFoundIndicatorBuilder: (_) => NoItemsFoundIndicator(),
            itemBuilder: (context, item, index) {
              print('++++++++++ $index');
              return _NotificationItem(
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
                  const CustomHeaderWidget(text: 'Notifications'),
                  Padding(
                      padding: EdgeInsets.all(13.w),
                      child: SizedBox(
                          height: 468.h,
                          width: 350.w,
                          child: _notificationPaginationList())),
                ],
              ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    super.key,
    required this.notification,
    required this.isNightMode,
  });
  final NotificationsModel notification;
  final bool isNightMode;
  @override
  Widget build(BuildContext context) {
    String formatNotificationDate(String createdAt) {
      // Parse the string to DateTime
      DateTime dateTime = DateTime.parse(createdAt);

      // Format the DateTime object
      String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);

      return formattedDate;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          _CustomUserProfileImage(
              image: notification.data.thumbnail, isActive: false),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  maxLines: 5,
                  textSize: 15.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.normal,
                  text: notification.data.content,
                ),
                CustomTextWidget(
                  textSize: 15.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade400,
                  text: formatNotificationDate(notification.createdAt),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomUserProfileImage extends StatelessWidget {
  const _CustomUserProfileImage({
    super.key,
    required this.image,
    required this.isActive,
  });

  final String image;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 25.w, // Increased size of the CircleAvatar
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: image,
              width: 120.w, // Increased width
              height: 120.w, // Added height to maintain aspect ratio
              fit: BoxFit.cover,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.kLogo,
                    width: 120.w, // Increased width of the fallback image
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 3.h,
          right: 4.w,
          child: isActive
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 8,
                )
              : SizedBox.shrink(),
        ),
        Positioned(
          bottom: 4.h,
          right: 5.w,
          child: isActive
              ? CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 6, // Increased size of the green circle
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
