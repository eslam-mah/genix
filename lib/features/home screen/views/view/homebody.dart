import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/stories_list_model.dart';
import 'package:genix/features/home%20screen/view%20model/add%20post/add_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/delete%20post/delete_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20stories/get_stories_cubit.dart';
import 'package:genix/features/home%20screen/views/widgets/custom_story_widget.dart';
import 'package:genix/features/home%20screen/views/widgets/post_shimmer_effect.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/pref_keys.dart';

import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';

import 'package:genix/core/widgets/glowing_button_body.dart';

import 'package:genix/features/home%20screen/views/widgets/custom_home_appbar.dart';

import 'package:genix/features/home%20screen/views/widgets/post%20types/post_item.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_body_page';
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  final PagingController<int, PostsModel> _pagingController =
      PagingController(firstPageKey: 1);

  final PagingController<int, StoriesListModel> _storiesPagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  late GetNewsFeedPostsCubit getPostsCubit;
  late GetStoriesCubit getStoriesCubit;
  bool isNightModeEnabled = false;

  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;
    getPostsCubit = BlocProvider.of<GetNewsFeedPostsCubit>(context);
    getStoriesCubit = BlocProvider.of<GetStoriesCubit>(context);
    context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
    _pagingController.addPageRequestListener((page) {
      getPostsCubit.getNewsFeedPosts();
    });
    _storiesPagingController.addPageRequestListener((page) {
      getStoriesCubit.getStories();
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetNewsFeedPostsCubit, GetNewsFeedPostsState>(
          listener: (context, state) {
            if (state is GetNewsFeedPostsSuccess) {
              state.posts.data.postsModel
                  .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
              _fetchPage(state.posts.data.postsModel);
            }
          },
        ),
        BlocListener<GetStoriesCubit, GetStoriesState>(
          listener: (context, state) {
            if (state is GetStoriesSuccess) {
              _fetchStories(state.stories.data.stories);
            }
          },
        ),
        BlocListener<DeletePostCubit, DeletePostState>(
          listener: (context, state) {
            if (state is DeletePostSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post deleted successfully.')),
              );
            } else if (state is DeletePostError) {
              final currentItems = _pagingController.itemList ?? [];
              final updatedItems = [...currentItems];
              _pagingController.itemList = updatedItems;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to delete post.')),
              );
            }
          },
        ),
        BlocListener<AddPostCubit, AddPostState>(
          listener: (context, state) {
            if (state is AddPostSuccess) {
              List<PostsModel> items = _pagingController.itemList ?? [];
              items.add(PostsModel(content: 'adding a post'));
              _pagingController.itemList = items;
              setState(() {});
            }
          },
        ),
        BlocListener<AddReactCubit, AddReactState>(
          listener: (context, state) {
            if (state is AddReactSuccess) {}
          },
        ),
        BlocListener<ThemeCubit, ThemeState>(
          listener: (context, state) {
            final isNightMode = state == ThemeState.dark;
            handleNightModeChanged(isNightMode);
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
                homeEnabled: false,
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
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 45.h,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.barsStaggered,
                size: 18.sp,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
          elevation: 0,
          title: BlocBuilder<GetNewsFeedPostsCubit, GetNewsFeedPostsState>(
            builder: (context, state) {
              if (state is GetNewsFeedPostsSuccess) {
                return CustomHomeAppBar(
                  postsModel: state.posts.data.postsModel.first,
                  refresh: () {
                    _pagingController.refresh();
                  },
                );
              } else {
                return Shimmer.fromColors(
                  baseColor: isNightModeEnabled
                      ? DarkModeColors.kItemColorDark3
                      : Colors.grey[100]!,
                  highlightColor: isNightModeEnabled
                      ? DarkModeColors.kItemColorDark3
                      : Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 30.h,
                    color: isNightModeEnabled
                        ? DarkModeColors.kItemColorDark3
                        : Colors.grey[100]!,
                  ),
                );
              }
            },
          ),
        ),
        endDrawer: CustomDrawerWidget(
          isNightMode: isNightModeEnabled,
        ),
        body: isSelected
            ? const GlowingButtonBody()
            : RefreshIndicator(
                color: AppColors.kPrimaryColor,
                onRefresh: () => Future.sync(
                  () {
                    setState(() {
                      _nextPageKey = 1;
                    });

                    _pagingController.refresh();
                    _storiesPagingController.refresh();
                  },
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: BlocBuilder<GetStoriesCubit, GetStoriesState>(
                        builder: (context, state) {
                          final hasStories = state is GetStoriesSuccess &&
                              state.stories.data.stories.isNotEmpty;
                          return Column(
                            children: [
                              const CustomHeaderWidget(
                                text: 'Newsfeed',
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: hasStories ? 90.h : 0,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: PagedListView<int, StoriesListModel>(
                                    scrollDirection: Axis.horizontal,
                                    pagingController: _storiesPagingController,
                                    builderDelegate: PagedChildBuilderDelegate<
                                        StoriesListModel>(
                                      animateTransitions: true,
                                      firstPageErrorIndicatorBuilder: (_) =>
                                          FirstPageErrorIndicator(
                                        onTryAgain: () =>
                                            _storiesPagingController.refresh(),
                                      ),
                                      firstPageProgressIndicatorBuilder: (_) =>
                                          const FirstPageProgressIndicator(),
                                      newPageProgressIndicatorBuilder: (_) =>
                                          const Center(
                                              child:
                                                  NewPageProgressIndicator()),
                                      noItemsFoundIndicatorBuilder: (_) =>
                                          const SizedBox.shrink(),
                                      itemBuilder: (context, item, index) {
                                        return CustomStoryWidget(
                                            storyModel: item);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    PagedSliverList<int, PostsModel>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<PostsModel>(
                        animateTransitions: true,
                        firstPageErrorIndicatorBuilder: (_) =>
                            FirstPageErrorIndicator(
                          onTryAgain: () => _pagingController.refresh(),
                        ),
                        firstPageProgressIndicatorBuilder: (_) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 15.h),
                          child: PostShimmerEffect(
                              isNightModeEnabled: isNightModeEnabled),
                        ),
                        newPageProgressIndicatorBuilder: (_) =>
                            const NewPageProgressIndicator(),
                        noItemsFoundIndicatorBuilder: (_) =>
                            const NoItemsFoundIndicator(),
                        itemBuilder: (context, item, index) {
                          // Your actual post item implementation
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<GetMyAccountDetailsCubit,
                                  GetMyAccountDetailsState>(
                                builder: (context, state) {
                                  if (state is GetMyAccountDetailsSuccess) {
                                    return PostItem(
                                      isNightModeEnabled: isNightModeEnabled,
                                      postsModel: item,
                                      id: state.account.data?.id ?? 0,
                                      refresh: () {
                                        _pagingController.refresh();
                                      },
                                      pagingController: _pagingController,
                                    );
                                  } else {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: double.infinity,
                                        height: 300.h,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _fetchPage(List<PostsModel> postsList) async {
    try {
      final newItems = postsList;
      final isLastPage = newItems.length < 20;
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

  Future<void> _fetchStories(List<StoriesListModel> storiesList) async {
    try {
      final newItems = storiesList;
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _storiesPagingController.appendLastPage(newItems);
      } else {
        _nextPageKey = _nextPageKey + 1;
        _storiesPagingController.appendPage(newItems, _nextPageKey);
      }
    } catch (error) {
      _storiesPagingController.error = error;
    }
  }
}
