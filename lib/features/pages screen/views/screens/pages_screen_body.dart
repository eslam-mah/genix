import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customappbar.dart';

import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';

import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/post_item.dart';
import 'package:genix/features/pages%20screen/view%20model/get_page_by_id/get_page_by_id_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagesScreen extends StatefulWidget {
  static const String route = "/pages_screen";
  final int id;
  const PagesScreen({
    super.key,
    required this.id,
  });

  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;

  bool isNightModeEnabled = false;
  final PagingController<int, PostsModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  late GetPageByIdCubit getPageByIdCubit;
  @override
  void initState() {
    super.initState();
    getPageByIdCubit = BlocProvider.of<GetPageByIdCubit>(context);
    context.read<GetPageByIdCubit>().getPageById(id: widget.id);
    _pagingController.addPageRequestListener((page) {
      print('**********PAGEKEY************ $page');
      getPageByIdCubit.getPageById(id: widget.id);
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
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
        BlocListener<GetPageByIdCubit, GetPageByIdState>(
          listener: (context, state) {
            if (state is GetPageByIdSuccess) {
              print(
                  'LENGTH All:: ${state.page.data?.posts?.collection?.length}');
              print('RESPONSE:: ${state.page.data?.posts?.collection}');
              _fetchPage(state.page.data?.posts?.collection ?? []);
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
                onRefresh: () async {
                  await context
                      .read<GetPageByIdCubit>()
                      .getPageById(id: widget.id);
                  _nextPageKey = 1;
                },
                child: BlocBuilder<GetPageByIdCubit, GetPageByIdState>(
                  builder: (context, state) {
                    if (state is GetPageByIdSuccess) {
                      final int average =
                          state.page.data?.page?.rating?.average ?? 0;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 400.h,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 350.h,
                                    child: Center(
                                      child: CachedNetworkImage(
                                        height: 350.h,
                                        imageUrl:
                                            state.page.data?.page?.coverImg ??
                                                '',
                                        fit: BoxFit.cover,
                                        errorWidget:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            AppImages.kLogo,
                                            height: 350.h,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15.h,
                                    left: 10.w,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(400.r),
                                      child: Container(
                                        width: 80.w,
                                        height: 80.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: state.page.data?.page
                                                  ?.profileImg ??
                                              '',
                                          fit: BoxFit.fill,
                                          errorWidget:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              AppImages.kLogo,
                                              width: 70.w,
                                              height: 70.w,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 100.w,
                                      bottom: 14.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextWidget(
                                              textSize: 17.sp,
                                              fontFamily: '',
                                              fontWeight: FontWeight.bold,
                                              text:
                                                  state.page.data?.page?.name ??
                                                      ''),
                                          Row(
                                            children: [
                                              for (int i = 0;
                                                  i <= (average - 1).floor();
                                                  i++) ...[
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 15.r,
                                                )
                                              ],
                                              CustomTextWidget(
                                                  textSize: 15.sp,
                                                  fontFamily: '',
                                                  fontWeight: FontWeight.normal,
                                                  text:
                                                      ' ${state.page.data?.page?.rating?.average ?? ''}'),
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  _DetailsRow(
                                    icon: FontAwesomeIcons.users,
                                    title: 'MEMBERS',
                                    isGreen: true,
                                    isInvite: false,
                                    detail:
                                        '${state.page.data?.page?.membersCount}',
                                  ),
                                  _DetailsRow(
                                    icon: FontAwesomeIcons.userTie,
                                    title: 'CREATOR',
                                    isGreen: true,
                                    isInvite: false,
                                    detail: state.page.data?.page?.creatorUser
                                            ?.showname ??
                                        '',
                                  ),
                                  _DetailsRow(
                                    icon: FontAwesomeIcons.solidSun,
                                    title: 'CATEGORY',
                                    isGreen: false,
                                    isInvite: false,
                                    detail:
                                        state.page.data?.page?.category ?? '',
                                  ),
                                  _DetailsRow(
                                    icon: FontAwesomeIcons.earthEurope,
                                    title: 'page',
                                    isGreen: false,
                                    isInvite: false,
                                    detail:
                                        state.page.data?.page?.isPrivate == true
                                            ? 'private'
                                            : 'public',
                                  ),
                                  _DetailsRow(
                                    icon: FontAwesomeIcons.link,
                                    title: 'WEBSITE',
                                    isGreen: true,
                                    isInvite: false,
                                    detail:
                                        state.page.data?.page?.website ?? '',
                                  ),
                                  const _DetailsRow(
                                    icon: FontAwesomeIcons.userPlus,
                                    title: 'INVITE',
                                    isGreen: false,
                                    isInvite: true,
                                    detail: '',
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomButton(
                                        buttonText: 'ABOUT',
                                        height: 30.h,
                                        borderRadius: 20.r,
                                        onTap: () {},
                                        width: 100.w,
                                        color: AppColors.kPrimaryColor,
                                      ),
                                      CustomButton(
                                        buttonText: 'PHOTOS',
                                        height: 30.h,
                                        borderRadius: 20.r,
                                        onTap: () {},
                                        width: 100.w,
                                        color: AppColors.kPrimaryColor,
                                      ),
                                      CustomButton(
                                        buttonText: 'EVENTS',
                                        height: 30.h,
                                        borderRadius: 20.r,
                                        onTap: () {},
                                        width: 100.w,
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  CustomButton(
                                    buttonText: 'CREATE NEW POST',
                                    height: 40.h,
                                    borderRadius: 5.r,
                                    onTap: () {},
                                    icon: Icon(
                                      Icons.add,
                                      size: 17.sp,
                                    ),
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                ],
                              ),
                            ),
                            _postsPaginationList()
                          ],
                        ),
                      );
                    } else if (state is GetPageByIdLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      );
                    } else if (state is GetPageByIdError) {
                      return Text(
                        'Error Loading Page',
                        style: TextStyle(fontSize: 25.sp),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      );
                    }
                  },
                ),
              ),
      ),
    );
  }
}

class _DetailsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final bool isGreen;
  final bool isInvite;
  const _DetailsRow({
    super.key,
    required this.icon,
    required this.title,
    required this.isGreen,
    required this.isInvite,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 16.r),
              SizedBox(
                width: 11.w,
              ),
              CustomTextWidget(
                  textSize: 16.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.normal,
                  text: '$title:'),
            ],
          ),
          isInvite
              ? Row(
                  children: [
                    CustomButton(
                      buttonText: '',
                      height: 30.h,
                      borderRadius: 5.r,
                      onTap: () {},
                      width: 50.w,
                      color: AppColors.kPrimaryColor,
                      icon: const Icon(FontAwesomeIcons.userPlus),
                    ),
                    SizedBox(
                      width: 60.w,
                    )
                  ],
                )
              : SizedBox(
                  width: 150.w,
                  child: CustomTextWidget(
                      textSize: 16.sp,
                      fontFamily: '',
                      fontWeight: FontWeight.normal,
                      color: isGreen ? Colors.green : null,
                      text: detail),
                )
        ],
      ),
    );
  }
}
