import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/models/stories_list_model.dart';
import 'package:genix/features/home%20screen/view%20model/add%20post/add_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20stories/get_stories_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/update%20post%20by%20id/update_post_by_id_cubit.dart';
import 'package:genix/features/home%20screen/views/widgets/content_post_item.dart';
import 'package:genix/features/home%20screen/views/widgets/custom_story_widget.dart';
import 'package:genix/features/home%20screen/views/widgets/event_item.dart';
import 'package:genix/features/home%20screen/views/widgets/link_post_item.dart';
import 'package:genix/features/home%20screen/views/widgets/poll_post_item.dart';
import 'package:genix/features/home%20screen/views/widgets/video_post_item.dart';
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

import 'package:genix/core/widgets/glowingbuttonbody.dart';

import 'package:genix/features/home%20screen/views/widgets/custom_home_appbar.dart';

import 'package:genix/features/home%20screen/views/widgets/post_item.dart';
import 'package:genix/features/home%20screen/views/widgets/story_list.dart';

enum PostType { image, video, poll, link, event, short, content }

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
    _pagingController.addPageRequestListener((page) {
      print('**********PAGEKEY************ $page');
      getPostsCubit.getNewsFeedPosts();
    });
    _storiesPagingController.addPageRequestListener((page) {
      print('**********PAGEKEY************ $page');
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
              print('LENGTH All:: ${state.posts.data.postsModel.length}');
              print('RESPONSE:: ${state.posts.data.postsModel}');
              _fetchPage(state.posts.data.postsModel);
            }
          },
        ),
        BlocListener<GetStoriesCubit, GetStoriesState>(
          listener: (context, state) {
            if (state is GetStoriesSuccess) {
              print('LENGTH All:: ${state.stories.data.stories.length}');
              print('RESPONSE:: ${state.stories.data.stories}');
              _fetchStories(state.stories.data.stories);
            }
          },
        ),
        BlocListener<AddPostCubit, AddPostState>(
          listener: (context, addState) {
            if (addState is AddPostSuccess) {
              List<PostsModel> items = _pagingController.itemList ?? [];
              items.insert(0, addState.post);
              _pagingController.itemList = items;
              print('adding success');
              setState(() {});
            }
          },
        ),
        BlocListener<UpdatePostByIdCubit, UpdatePostByIdState>(
          listener: (context, updateState) {
            if (updateState is UpdatePostByIdSuccess) {
              final int? index =
                  _pagingController.itemList?.indexWhere((oldPost) {
                return (oldPost.id == updateState.updatePost.id);
              });
              if (index != null && index >= 0) {
                _pagingController.itemList?[index] = updateState.updatePost;
                setState(() {});
              }
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: isNightModeEnabled ? Colors.black : Colors.white,
        key: _scaffoldKey,
        bottomNavigationBar: SafeArea(
            child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CustomBottomAppBar(
              isNightMode: isNightModeEnabled,
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
          backgroundColor: AppColors.kAppBar2Color,
          elevation: 0,
          title: const CustomHomeAppBar(),
        ),
        endDrawer: CustomDrawerWidget(
          onNightModeChanged: handleNightModeChanged,
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
                              CustomHeaderWidget(
                                text: 'Newsfeed',
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: hasStories ? 90.h : 0,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: PagedListView<int, StoriesListModel>(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.zero,
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
                                          FirstPageProgressIndicator(),
                                      newPageProgressIndicatorBuilder: (_) =>
                                          const Center(
                                              child:
                                                  NewPageProgressIndicator()),
                                      noItemsFoundIndicatorBuilder: (_) =>
                                          SizedBox.shrink(),
                                      itemBuilder: (context, item, index) {
                                        print('++++++++++ $index');
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
                        firstPageProgressIndicatorBuilder: (_) =>
                            FirstPageProgressIndicator(),
                        newPageProgressIndicatorBuilder: (_) =>
                            const NewPageProgressIndicator(),
                        noItemsFoundIndicatorBuilder: (_) =>
                            NoItemsFoundIndicator(),
                        itemBuilder: (context, item, index) {
                          print('++++++++++ $index');
                          final postTypes = _determinePostTypes(item);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _getPostTypeWidgets(postTypes, item),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  List<PostType> _determinePostTypes(PostsModel postModel) {
    final List<PostType> postTypes = [];
    if (postModel.uploads != null) {
      if (postModel.uploads!.any((upload) =>
          upload.type == "image/png" ||
          upload.type == "image/jpeg" ||
          upload.type == "image/webp")) {
        postTypes.add(PostType.image);
      }
      if (postModel.uploads!.any((upload) => upload.type == 'video')) {
        postTypes.add(PostType.video);
      }
    }
    if (postModel.misc != null && postModel.misc!.poll != null) {
      if (postModel.misc!.poll != null) {
        postTypes.add(PostType.poll);
      }
    }
    if (postModel.ogInfo != null) {
      postTypes.add(PostType.link);
    }
    if (postModel.isEvent == true) {
      postTypes.add(PostType.event);
    }
    if (postModel.isVideoShort == true) {
      postTypes.add(PostType.short);
    }
    if (postModel.uploads == null &&
        postModel.ogInfo == null &&
        postModel.misc == null) {
      postTypes.add(PostType.content);
    }
    return postTypes;
  }

  List<Widget> _getPostTypeWidgets(
      List<PostType> postTypes, PostsModel postModel) {
    return postTypes
        .map((postType) => _getPostType(postType, postModel))
        .toList();
  }

  Widget _getPostType(PostType postType, PostsModel postModel) {
    switch (postType) {
      case PostType.image:
        print(
            "_____________________${postModel.misc}___________________________");
        return PostItem(
          isNightModeEnabled: isNightModeEnabled,
          postsModel: postModel,
        );
      case PostType.video:
        return VideoPostItem(
            isNightModeEnabled: isNightModeEnabled,
            postsModel: postModel); // Implement video widget
      case PostType.poll:
        return PollPostItem(
            isNightModeEnabled: isNightModeEnabled,
            postsModel: postModel); // Implement poll widget
      case PostType.event:
        return EventItem(
          isNightModeEnabled: isNightModeEnabled,
          postsModel: postModel,
        ); // Implement event widget
      case PostType.link:
        return LinkPostItem(
            isNightModeEnabled: isNightModeEnabled, postsModel: postModel);
      case PostType.short:
        return Text('short'); // Implement short video widget
      case PostType.content:
        return ContentPostItem(
            isNightModeEnabled: isNightModeEnabled,
            postsModel: postModel); // Implement content widget
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _fetchPage(List<PostsModel> postsList) async {
    try {
      final newItems = postsList;
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

  Future<void> _fetchStories(List<StoriesListModel> storiesList) async {
    try {
      final newItems = storiesList;
      print('fetch:: ${newItems.length}');
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _storiesPagingController.appendLastPage(newItems);
      } else {
        _nextPageKey = _nextPageKey + 1;
        _storiesPagingController.appendPage(newItems, _nextPageKey);
      }
    } catch (error) {
      print('Pagination error: ${error.toString()}');
      _storiesPagingController.error = error;
    }
  }
}
