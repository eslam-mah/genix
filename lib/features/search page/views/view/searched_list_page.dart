import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/groups%20page/data/models/groups_model.dart';
import 'package:genix/features/groups%20page/views/widgets/group_item.dart';
import 'package:genix/features/pages%20screen/data/models/pages_model.dart';
import 'package:genix/features/pages%20screen/views/widgets/page_item.dart';
import 'package:genix/features/search%20page/view%20model/search/search_cubit.dart';
import 'package:genix/features/search%20page/views/widgets/user_item.dart';
import 'package:genix/features/users/data/models/user_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchedListPage extends StatefulWidget {
  static const String route = '/search_list';
  final String searchQuery;
  final String
      searchType; // Add searchType parameter to specify users, groups, or pages

  const SearchedListPage(
      {super.key, required this.searchQuery, required this.searchType});

  @override
  State<SearchedListPage> createState() => _SearchedListPageState();
}

class _SearchedListPageState extends State<SearchedListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;
  late SearchCubit searchCubit;

  // Paging controllers for users and groups/pages
  final PagingController<int, UserModel> _userPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, GroupsModel> _groupsPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, PagesModel> _pagesPagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;

    searchCubit = BlocProvider.of<SearchCubit>(context);

    // Set the page request listener based on search type
    if (widget.searchType == '1') {
      // Search for users
      _userPagingController.addPageRequestListener((page) {
        searchCubit.searchByUser(query: widget.searchQuery);
      });
    } else if (widget.searchType == '2') {
      // Search for groups or pages
      _groupsPagingController.addPageRequestListener((page) {
        searchCubit.searchByGroup(query: widget.searchQuery);
      });
    } else {
      _pagesPagingController.addPageRequestListener((page) {
        searchCubit.searchByPage(query: widget.searchQuery);
      });
    }
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  // Fetch users page
  Future<void> _fetchUserPage(List<UserModel> userList) async {
    try {
      final newItems = userList;
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _userPagingController.appendLastPage(newItems);
      } else {
        _userPagingController.appendPage(
            newItems, _userPagingController.nextPageKey! + 1);
      }
    } catch (error) {
      _userPagingController.error = error;
    }
  }

  // Fetch groups/page page
  Future<void> _fetchGroupsPage(List<GroupsModel> groupsList) async {
    try {
      final newItems = groupsList;
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _groupsPagingController.appendLastPage(newItems);
      } else {
        _groupsPagingController.appendPage(
            newItems, _groupsPagingController.nextPageKey! + 1);
      }
    } catch (error) {
      _groupsPagingController.error = error;
    }
  }

  Future<void> _fetchPagesPage(List<PagesModel> pagesList) async {
    try {
      final newItems = pagesList;
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagesPagingController.appendLastPage(newItems);
      } else {
        _pagesPagingController.appendPage(
            newItems, _groupsPagingController.nextPageKey! + 1);
      }
    } catch (error) {
      _pagesPagingController.error = error;
    }
  }

  // Widget for displaying users' search results
  Widget _pagePaginationList() {
    return PagedSliverList<int, PagesModel>(
      pagingController: _pagesPagingController,
      builderDelegate: PagedChildBuilderDelegate<PagesModel>(
          animateTransitions: true,
          firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                onTryAgain: () => _pagesPagingController.refresh(),
              ),
          firstPageProgressIndicatorBuilder: (_) =>
              const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) =>
              const NewPageProgressIndicator(),
          noItemsFoundIndicatorBuilder: (_) => const NoItemsFoundIndicator(),
          itemBuilder: (context, page, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: PageItem(page: page),
            );
          }),
    );
  }

  // Widget for displaying users' search results
  Widget _userPaginationList() {
    return PagedSliverList<int, UserModel>(
      pagingController: _userPagingController,
      builderDelegate: PagedChildBuilderDelegate<UserModel>(
          animateTransitions: true,
          firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                onTryAgain: () => _userPagingController.refresh(),
              ),
          firstPageProgressIndicatorBuilder: (_) =>
              const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) =>
              const NewPageProgressIndicator(),
          noItemsFoundIndicatorBuilder: (_) => const NoItemsFoundIndicator(),
          itemBuilder: (context, user, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: UserItem(user: user),
            );
          }),
    );
  }

  // Widget for displaying groups/pages search results
  Widget _groupsPaginationList() {
    return PagedSliverList<int, GroupsModel>(
      pagingController: _groupsPagingController,
      builderDelegate: PagedChildBuilderDelegate<GroupsModel>(
          animateTransitions: true,
          firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                onTryAgain: () => _groupsPagingController.refresh(),
              ),
          firstPageProgressIndicatorBuilder: (_) =>
              const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) =>
              const NewPageProgressIndicator(),
          noItemsFoundIndicatorBuilder: (_) => const NoItemsFoundIndicator(),
          itemBuilder: (context, group, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: GroupItem(group: group),
            );
          }),
    );
  }

  Widget searchResults() {
    switch (widget.searchType) {
      case '1':
        return _userPaginationList();
      case '2':
        return _groupsPaginationList();
      case '3':
        return _pagePaginationList();
      default:
        return _userPaginationList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchByUserSuccess && widget.searchType == '1') {
              _fetchUserPage(state.users.data.collection);
            } else if (state is SearchByGroupSuccess &&
                widget.searchType == '2') {
              _fetchGroupsPage(state.groups.data.collection);
            } else if (state is SearchByPageSuccess &&
                widget.searchType == '3') {
              _fetchPagesPage(state.pages.data.collection);
            }
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
                _scaffoldKey.currentState?.openEndDrawer(); // Open the drawer
              },
            ),
          ],
          elevation: 0,
          title: const CustomAppBar(),
        ),
        endDrawer: CustomDrawerWidget(isNightMode: isNightModeEnabled),
        body: isSelected
            ? const GlowingButtonBody()
            : CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: CustomHeaderWidget(text: 'Search results'),
                  ),
                  searchResults()
                ],
              ),
      ),
    );
  }
}
