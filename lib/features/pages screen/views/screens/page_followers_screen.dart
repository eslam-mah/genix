import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
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
import 'package:genix/features/pages%20screen/data/models/page_profile_model/member.dart';

import 'package:genix/features/pages%20screen/data/models/page_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/view%20model/get_page_members/get_page_members_cubit.dart';
import 'package:genix/features/pages%20screen/views/widgets/follower_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/localization/all_app_strings.dart';

class PageFollowersScreen extends StatefulWidget {
  static const String route = '/page_followers';
  final PageProfileModel page;
  const PageFollowersScreen({super.key, required this.page});

  @override
  State<PageFollowersScreen> createState() => _PageFollowersScreenState();
}

class _PageFollowersScreenState extends State<PageFollowersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;
  late GetPageMembersCubit getPageMembersCubit;
  int _nextPageKey = 1;

  final PagingController<int, Member> _membersPagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;

    getPageMembersCubit = BlocProvider.of<GetPageMembersCubit>(context);
    _membersPagingController.addPageRequestListener((page) {
      getPageMembersCubit.getPageMembers(
          id: widget.page.data?.page?.id ?? 0, page: page);
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  // Fetch users page
  Future<void> _fetchPage(List<Member> items) async {
    try {
      final newItems = items;
      final isLastPage = newItems.length < 20; // Adjust based on your page size

      if (_nextPageKey == 1) {
        _membersPagingController.itemList?.clear();
      }

      if (isLastPage) {
        _membersPagingController.appendLastPage(newItems);
      } else {
        _nextPageKey = _nextPageKey + 1;
        _membersPagingController.appendPage(newItems, _nextPageKey);
      }
    } catch (error) {
      _membersPagingController.error = error;
    }
  }

  // Widget for displaying users' search results
  Widget _memberPaginationList() {
    return PagedSliverList<int, Member>(
      pagingController: _membersPagingController,
      builderDelegate: PagedChildBuilderDelegate<Member>(
          animateTransitions: true,
          firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                onTryAgain: () => _membersPagingController.refresh(),
              ),
          firstPageProgressIndicatorBuilder: (_) =>
              const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) =>
              const NewPageProgressIndicator(),
          noItemsFoundIndicatorBuilder: (_) => const NoItemsFoundIndicator(),
          itemBuilder: (context, item, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: FollowerItem(
                user: item,
                pageProfileModel: widget.page,
                refresh: () => _membersPagingController.refresh(),
              ),
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
        BlocListener<GetPageMembersCubit, GetPageMembersState>(
          listener: (context, state) {
            if (state is GetPageMembersSuccess) {
              _fetchPage(state.member.data.collection);
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
                   SliverToBoxAdapter(
                    child: CustomHeaderWidget(text: '${AppStrings.followers.getString(context)}'),
                  ),
                  _memberPaginationList()
                ],
              ),
      ),
    );
  }
}
