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
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';

import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/photos%20page/data/models/photos_model.dart';
import 'package:genix/features/photos%20page/view%20model/get%20photo%20posts/get_photo_posts_cubit.dart';
import 'package:genix/features/photos%20page/view%20model/get%20photo%20posts/get_photo_posts_state.dart';
import 'package:genix/features/photos%20page/views/widgets/photo_item.dart';

import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyPhotosPage extends StatefulWidget {
  const MyPhotosPage({super.key});
  static const route = '/my_photos';
  @override
  State<MyPhotosPage> createState() => _MyPhotosPageState();
}

class _MyPhotosPageState extends State<MyPhotosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;

  bool isNightModeEnabled = false;
  late GetPhotoPostsCubit getPhotosCubit;
  final PagingController<int, PhotosModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  @override
  void initState() {
    super.initState();
    getPhotosCubit = BlocProvider.of<GetPhotoPostsCubit>(context);
    context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  Future<void> _getPhotosList(int id) async {
    _pagingController.addPageRequestListener((page) {
      getPhotosCubit.getPhotoPosts(uid: id);
    });
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  Future<void> _fetchPage(List<PhotosModel> photosList) async {
    try {
      final newItems = photosList;
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

  Widget _photosPaginationList() {
    return PagedSliverGrid<int, PhotosModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<PhotosModel>(
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
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: PhotoItem(
                photosModel: item,
              ),
            );
          }),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 10.w,
        childAspectRatio: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetPhotoPostsCubit, GetPhotoPostsState>(
          listener: (context, state) {
            if (state is GetPhotoPostsSuccess) {
              _fetchPage(state.photoPosts.data.collection);
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
              : BlocBuilder<GetMyAccountDetailsCubit, GetMyAccountDetailsState>(
                  builder: (context, state) {
                    if (state is GetMyAccountDetailsSuccess) {
                      final id = state.account.data?.id ?? 0;
                      _getPhotosList(id);
                      return CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: CustomHeaderWidget(text: 'My photos'),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 15.w),
                              child: const CustomHeaderWidget2(
                                  text: 'Recent photos'),
                            ),
                          ),
                          _photosPaginationList()
                        ],
                      );
                    } else if (state is GetMyAccountDetailsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'error loading page',
                          style: TextStyle(fontSize: 24.sp),
                        ),
                      );
                    }
                  },
                )),
    );
  }
}
