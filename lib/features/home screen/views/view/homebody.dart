import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/view%20model/add%20post/add_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/update%20post%20by%20id/update_post_by_id_cubit.dart';
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
  int _nextPagekey = 1;
  late GetNewsFeedPostsCubit getPostsCubit;
  bool isNightModeEnabled = false;

  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;
    getPostsCubit = BlocProvider.of<GetNewsFeedPostsCubit>(context);

    _pagingController.addPageRequestListener((page) {
      print('**********PAGEKEY************ $page');
      getPostsCubit.getNewsFeedPosts();
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
        BlocListener<AddPostCubit, AddPostState>(
          listener: (context, addState) {
            if (addState is AddPostSuccess) {
              List<PostsModel> items = _pagingController.itemList ?? [];
              items.insert(0, addState.post);
              _pagingController.itemList = items;
              print('adinggggggggggg successssssssss+++');
              setState(() {});
            }
          },
        ),
        BlocListener<UpdatePostByIdCubit, UpdatePostByIdState>(
          listener: (context, updateState) {
            if (updateState is UpdatePostByIdSuccess) {
              final int? index;
              index = _pagingController.itemList?.indexWhere((oldPost) {
                return (oldPost.id == updateState.updatePost.id);
              });
              print('=============---------&&&&&&&&&&------ $index');
              _pagingController.itemList?.removeAt(index!);

              _pagingController.itemList
                  ?.insert(index!, updateState.updatePost);
              setState(() {});
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
            : CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomHeaderWidget(
                          text: 'Newsfeed',
                        ),
                        StoryList()
                      ],
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
                        return PostItem(
                          isNightModeEnabled: isNightModeEnabled,
                          postsModel: item,
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _fetchPage(List<PostsModel> postsList) async {
    try {
      final newItems = postsList;
      print('fetch:: ${newItems.length}');
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _nextPagekey = _nextPagekey + 1;
        _pagingController.appendPage(newItems, _nextPagekey);
      }
    } catch (error) {
      print('?????????????? pagination error ${error.toString()}');
      _pagingController.error = error;
    }
  }
}
