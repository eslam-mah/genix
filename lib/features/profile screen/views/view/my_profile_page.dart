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
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/widgets/blockeduserslistview.dart';
import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/followingslistview.dart';
import 'package:genix/features/photos%20page/views/view/my_photos_page.dart';
import 'package:genix/features/profile%20screen/views/widgets/saved_shorts.dart';
import 'package:genix/features/profile%20screen/views/widgets/shorts_list_view.dart';
import 'package:genix/features/followers%20list%20page/views/view/my_followers_page.dart';
import 'package:genix/features/followers%20list%20page/views/widgets/followers_list_view.dart';
import 'package:genix/features/followings%20list%20page/views/view/followings_page.dart';
import 'package:genix/features/groups%20page/views/widgets/groups_list_view.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/post_item.dart';
import 'package:genix/features/profile%20screen/view%20model/get%20profile/get_profile_cubit.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_icon_listview.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_profile_header.dart';
import 'package:genix/features/photos%20page/views/widgets/photos_List_view.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_profile_shimmer.dart';
import 'package:genix/features/profile%20screen/views/widgets/recent_posts_list.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20profile/update_my_profile_cubit.dart';
import 'package:genix/features/videos%20page/views/view/my_videos_page.dart';
import 'package:genix/features/videos%20page/views/widgets/videos_list_view.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({
    super.key,
  });
  static const String route = '/my_profile';
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;

  bool isNightModeEnabled = false;
  final PagingController<int, PostsModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;

  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;

    context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  void _getProfile(String username) {
    context.read<GetProfileCubit>().getProfile(profileName: username);
  }

  Future<void> _refreshProfile() async {
    _nextPageKey = 1;
    _pagingController.refresh();
    await context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  Future<void> _fetchPage(List<PostsModel> posts) async {
    try {
      final newItems = posts;
      print('fetch:: ${newItems.length}');

      // Clear existing items if refreshing the first page
      if (_nextPageKey == 1) {
        _pagingController.itemList?.clear();
      }

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

  Widget _postsPaginationList() {
    return PagedListView<int, PostsModel>(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<PostsModel>(
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
            return PostItem(
              isNightModeEnabled: isNightModeEnabled,
              postsModel: item,
              id: 0,
              refresh: () {
                _pagingController.refresh();
              },
              pagingController: _pagingController,
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ThemeCubit, ThemeState>(
          listener: (context, state) {
            final isNightMode = state == ThemeState.dark;
            handleNightModeChanged(isNightMode);
          },
        ),
        BlocListener<GetProfileCubit, GetProfileState>(
          listener: (context, state) {
            if (state is GetProfileSuccess) {
              _fetchPage(state.profiles.data?.recentPosts ?? []);
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
            const CustomBottomAppBar(
              profileEnabled: false,
            ),
            Positioned(
                bottom: 20.h,
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
            : BlocBuilder<GetMyAccountDetailsCubit, GetMyAccountDetailsState>(
                builder: (context, state) {
                  if (state is GetMyAccountDetailsLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ));
                  } else if (state is GetMyAccountDetailsSuccess) {
                    final username = state.account.data?.username;
                    _getProfile(username ?? '');
                    return BlocBuilder<GetProfileCubit, GetProfileState>(
                      builder: (context, state) {
                        if (state is GetProfileLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.kPrimaryColor,
                          ));
                        } else if (state is GetProfileSuccess) {
                          final profileModel = state.profiles;
                          return RefreshIndicator(
                            onRefresh: _refreshProfile,
                            child: CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      CustomProfileHeader(
                                        isProfileEditorShown: true,
                                        refresh: () {
                                          setState(() {
                                            _refreshProfile();
                                          });
                                        },
                                        profileModel: state.profiles,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      const CustomIconButtonListView()
                                    ],
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomHeaderWidget2(
                                                        text: 'Photos')),
                                                InkWell(
                                                    onTap: () {
                                                      GoRouter.of(context).push(
                                                          MyPhotosPage.route);
                                                    },
                                                    child: const Text(
                                                      'See all',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ))
                                              ],
                                            ),
                                            PhotosGridView(
                                              profileModel: profileModel,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomHeaderWidget2(
                                                        text: 'Videos')),
                                                InkWell(
                                                    onTap: () {
                                                      GoRouter.of(context).push(
                                                          MyVideosPage.route);
                                                    },
                                                    child: const Text(
                                                      'See all',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ))
                                              ],
                                            ),
                                            VideosGridView(
                                              profileModel: profileModel,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomHeaderWidget2(
                                                        text: 'Shorts')),
                                                InkWell(
                                                    onTap: () {},
                                                    child: const Text(
                                                      'See all',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ))
                                              ],
                                            ),
                                            ShortsListView(
                                                profileModel: profileModel)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomHeaderWidget2(
                                                        text: 'Saved shorts')),
                                                InkWell(
                                                    onTap: () {},
                                                    child: const Text(
                                                      'See all',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ))
                                              ],
                                            ),
                                            SavedShortsListView(
                                              profileModel: profileModel,
                                            )
                                          ],
                                        ),
                                        // Column(
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         const Expanded(
                                        //             child: CustomHeaderWidget2(
                                        //                 text: 'Recent posts')),
                                        //         InkWell(
                                        //             onTap: () {},
                                        //             child: const Text(
                                        //               'See all',
                                        //               style: TextStyle(
                                        //                   color: Colors.green),
                                        //             ))
                                        //       ],
                                        //     ),
                                        //     RecentPostsList(
                                        //         profileModel: profileModel)
                                        //   ],
                                        // ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomHeaderWidget2(
                                                        text: 'Followers')),
                                                InkWell(
                                                    onTap: () {
                                                      GoRouter.of(context).push(
                                                          MyFollowersPage
                                                              .route);
                                                    },
                                                    child: const Text(
                                                      'See all',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ))
                                              ],
                                            ),
                                            FollowersListView(
                                                profileModel: profileModel)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomHeaderWidget2(
                                                        text: 'Following')),
                                                InkWell(
                                                    onTap: () {
                                                      GoRouter.of(context).push(
                                                          FollowingsPage.route,
                                                          extra: state
                                                                  .profiles
                                                                  .data
                                                                  ?.user
                                                                  ?.id ??
                                                              0);
                                                    },
                                                    child: const Text(
                                                      'See all',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ))
                                              ],
                                            ),
                                            FollowingsListView(
                                                profileModel: profileModel)
                                          ],
                                        ),
                                        // Column(
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         const Expanded(
                                        //             child: CustomHeaderWidget2(
                                        //                 text: 'Blocked')),
                                        //         InkWell(
                                        //             onTap: () {},
                                        //             child: const Text(
                                        //               'See all',
                                        //               style: TextStyle(
                                        //                   color: Colors.green),
                                        //             ))
                                        //       ],
                                        //     ),
                                        //     BlockedListView(
                                        //         height: 150.h,
                                        //         profileModel: profileModel)
                                        //   ],
                                        // ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: CustomHeaderWidget2(
                                                        text: 'Groups')),
                                                InkWell(
                                                    onTap: () {},
                                                    child: const Text(
                                                      'See all',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ))
                                              ],
                                            ),
                                            GroupsGridView(
                                              height: 130.h,
                                              crossAxisCount: 2,
                                              direction: Axis.vertical,
                                              profileModel: profileModel,
                                              isNightMode: isNightModeEnabled,
                                            )
                                          ],
                                        ),
                                        // Column(
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         const Expanded(
                                        //             child: CustomHeaderWidget2(
                                        //                 text: 'Restricted')),
                                        //         InkWell(
                                        //             onTap: () {},
                                        //             child: const Text(
                                        //               'See all',
                                        //               style: TextStyle(
                                        //                   color: Colors.green),
                                        //             ))
                                        //       ],
                                        //     ),
                                        //     RestrictedUsersListView(
                                        //         height: 150.h,
                                        //         profileModel: profileModel)
                                        //   ],
                                        // ),
                                        Column(
                                          children: [
                                            const CustomHeaderWidget2(
                                                text: 'Recent posts'),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            _postsPaginationList(),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (state is GetProfileError) {
                          return const Center(
                              child: Text('Error loading profile'));
                        } else {
                          return const Center(child: ProfileShimmer());
                        }
                      },
                    );
                  } else if (state is GetMyAccountDetailsError) {
                    return const Center(
                        child: Text('Error loading account details'));
                  } else {
                    return const Center(child: ProfileShimmer());
                  }
                },
              ),
      ),
    );
  }
}
