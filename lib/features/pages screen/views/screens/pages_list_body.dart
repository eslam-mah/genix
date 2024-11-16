import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
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
import 'package:genix/features/pages%20screen/data/models/pages_model.dart';
import 'package:genix/features/pages%20screen/view%20model/get_all_pages/get_all_pages_cubit.dart';
import 'package:genix/features/pages%20screen/views/widgets/create_page/create_page_bottom_sheet.dart';
import 'package:genix/features/pages%20screen/views/widgets/page_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/localization/all_app_strings.dart';

class PagesListBody extends StatefulWidget {
  static const String route = "/pages_list";
  const PagesListBody({super.key});

  @override
  State<PagesListBody> createState() => _PagesListBodyState();
}

class _PagesListBodyState extends State<PagesListBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;

  bool isNightModeEnabled = false;
  late GetAllPagesCubit getPagesCubit;
  final PagingController<int, PagesModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  @override
  void initState() {
    super.initState();
    getPagesCubit = BlocProvider.of<GetAllPagesCubit>(context);
    _pagingController.addPageRequestListener((page) {
      getPagesCubit.getAllPages(page: page);
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  Future<void> _fetchPage(List<PagesModel> items) async {
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

  Widget _pagesPaginationList() {
    return PagedSliverList<int, PagesModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<PagesModel>(
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
              child: PageItem(
                page: item,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetAllPagesCubit, GetAllPagesState>(
          listener: (context, state) {
            if (state is GetAllPagesSuccess) {
              print('LENGTH All:: ${state.pages.data.collection.length}');
              print('RESPONSE:: ${state.pages.data.collection}');
              _fetchPage(state.pages.data.collection);
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
                       SliverToBoxAdapter(
                        child: CustomHeaderWidget(text: '${AppStrings.pages.getString(context)}'),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 20.w, right: 20.w),
                          child: CustomButton(
                            buttonText: '${AppStrings.createnewpage.getString(context)}',
                            height: 40.h,
                            borderRadius: 10.r,
                            color: AppColors.kPrimaryColor,
                            onTap: () {
                              createPageBottomSheet(context, () {
                                _pagingController.refresh();
                              });
                            },
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
                          child:  CustomHeaderWidget2(text: '${AppStrings.pages.getString(context)}'),
                        ),
                      ),
                      _pagesPaginationList()
                    ],
                  ),
                )),
    );
  }
}
