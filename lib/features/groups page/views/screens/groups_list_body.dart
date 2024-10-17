import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/groups%20page/data/models/groups_model.dart';
import 'package:genix/features/groups%20page/view%20model/get_all_groups/get_all_groups_cubit.dart';
import 'package:genix/features/groups%20page/views/widgets/group_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GroupsListBody extends StatefulWidget {
  static const String route = "/groups_list";
  const GroupsListBody({super.key});

  @override
  State<GroupsListBody> createState() => _GroupsListBodyState();
}

class _GroupsListBodyState extends State<GroupsListBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;

  bool isNightModeEnabled = false;
  late GetAllGroupsCubit getGroupsCubit;
  final PagingController<int, GroupsModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  @override
  void initState() {
    super.initState();
    getGroupsCubit = BlocProvider.of<GetAllGroupsCubit>(context);
    _pagingController.addPageRequestListener((page) {
      getGroupsCubit.getAllGroups();
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  Future<void> _fetchPage(List<GroupsModel> groupsList) async {
    try {
      final newItems = groupsList;
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

  Widget _groupsPaginationList() {
    return PagedSliverList<int, GroupsModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<GroupsModel>(
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
              child: GroupItem(
                group: item,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetAllGroupsCubit, GetAllGroupsState>(
          listener: (context, state) {
            if (state is GetAllGroupsSuccess) {
              print('LENGTH All:: ${state.groups.data.collection.length}');
              print('RESPONSE:: ${state.groups.data.collection}');
              _fetchPage(state.groups.data.collection);
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
                      const SliverToBoxAdapter(
                        child: CustomHeaderWidget(text: 'Groups'),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 20.w, right: 20.w),
                          child: CustomButton(
                            buttonText: 'CREATE NEW GROUP',
                            height: 40.h,
                            borderRadius: 10.r,
                            color: AppColors.kPrimaryColor,
                            onTap: () {},
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 15.w),
                          child: const CustomHeaderWidget2(text: 'Groups'),
                        ),
                      ),
                      _groupsPaginationList()
                    ],
                  ),
                )),
    );
  }
}
