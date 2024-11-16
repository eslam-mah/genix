import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/core/widgets/customappbar.dart';

import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';

import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/followers%20list%20page/data/models/followers_model.dart';
import 'package:genix/features/followers%20list%20page/view%20model/get%20followers/get_followers_cubit.dart';
import 'package:genix/features/followers%20list%20page/views/widgets/follower_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/localization/all_app_strings.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({super.key, required this.id});
  static const route = '/followers';
  final int id;
  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;

  bool isNightModeEnabled = false;
  late GetFollowersCubit getFollowersCubit;
  final PagingController<int, FollowersModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  @override
  void initState() {
    super.initState();
    getFollowersCubit = BlocProvider.of<GetFollowersCubit>(context);
    _pagingController.addPageRequestListener((page) {
      getFollowersCubit.getFollowers(id: widget.id, page: page);
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  Future<void> _fetchPage(List<FollowersModel> items) async {
    try {
      final newItems = items;
      final isLastPage = newItems.length < 20; // Adjust based on your page size

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

  Widget _followersPaginationList() {
    return PagedSliverList<int, FollowersModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<FollowersModel>(
          animateTransitions: true,
          firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                onTryAgain: () => _pagingController.refresh(),
              ),
          firstPageProgressIndicatorBuilder: (_) =>
              const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) =>
              const NewPageProgressIndicator(),
          noItemsFoundIndicatorBuilder: (_) => const NoItemsFoundIndicator(),
          itemBuilder: (context, item, index) {
            print('++++++++++ $index');
            return Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 10.h),
              child: FollowerWidget(
                user: item,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetFollowersCubit, GetFollowersState>(
          listener: (context, state) {
            if (state is GetFollowersSuccess) {
              _fetchPage(state.followers.data.collection);
            }
          },
        ),
      ],
      child: Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: SafeArea(
              child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const CustomBottomAppBar(),
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
              : CustomScrollView(
                  slivers: [
                     SliverToBoxAdapter(
                      child: CustomHeaderWidget(text: '${AppStrings.followers.getString(context)}'),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 15.w),
                        child:
                             CustomHeaderWidget2(text: '${AppStrings.recentfollowers.getString(context)}'),
                      ),
                    ),
                    _followersPaginationList()
                  ],
                )),
    );
  }
}
