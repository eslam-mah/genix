import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/widgets/customtextwidget.dart';

import 'package:genix/core/widgets/video_player_page.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/add_short_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/get_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/update_short_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/add_video_bottom_sheet.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/donations_bottom_sheet.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/shorts_comments_bottom_sheet.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/custom_add_button.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/custom_shorts_button.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/shorts_bottom_appbar.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/shorts_share_bottom_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class VideoShortsBody extends StatefulWidget {
  const VideoShortsBody({super.key});
  static const String route = '/shorts';

  @override
  State<VideoShortsBody> createState() => _VideoShortsBodyState();
}

class _VideoShortsBodyState extends State<VideoShortsBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isNightModeEnabled = false;
  final PagingController<int, ShortsModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  int likes = 0;
  bool isLiked = false;
  int saves = 0;
  bool isSaved = false;
  late GetShortsCubit getShortsCubit;
  bool isMute = false;

  @override
  void initState() {
    super.initState();
    getShortsCubit = BlocProvider.of<GetShortsCubit>(context);
    _pagingController.addPageRequestListener((page) {
      getShortsCubit.getShorts();
    });
  }

  Future<void> _fetchPage(List<ShortsModel> shortsList) async {
    try {
      final newItems = shortsList;
      final isLastPage = newItems.length < 1000;
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

  String _removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetShortsCubit, GetShortsState>(
          listener: (context, state) {
            if (state is GetShortsSuccess) {
              _fetchPage(state.shorts.data.collection);
            }
          },
        ),
        BlocListener<AddShortCubit, AddShortState>(
          listener: (context, addState) {
            if (addState is AddShortSuccess) {
              List<ShortsModel> items = _pagingController.itemList ?? [];
              items.insert(0, addState.short);
              _pagingController.itemList = items;
              setState(() {});
            }
          },
        ),
        BlocListener<UpdateShortCubit, UpdateShortState>(
          listener: (context, updateState) {
            if (updateState is UpdateShortSuccess) {
              final int? index =
                  _pagingController.itemList?.indexWhere((oldShort) {
                return (oldShort.id == updateState.short.id);
              });
              if (index != null && index >= 0) {
                _pagingController.itemList?[index] = updateState.short;
                setState(() {});
              }
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldKey,
        endDrawer: CustomDrawerWidget(
          isNightMode: isNightModeEnabled,
        ),
        bottomNavigationBar: SafeArea(
            child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CustomShortsBottomAppBar(
              isNightMood: isNightModeEnabled,
            ),
            Positioned(
                bottom: 10,
                child: InkWell(
                  onTap: () {
                    addVideoBottomSheet(context);
                  },
                  child: const CustomAddButton(),
                ))
          ],
        )),
        body: SafeArea(
          child: PagedListView<int, ShortsModel>(
            scrollDirection: Axis.vertical,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<ShortsModel>(
              firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
                onTryAgain: () => _pagingController.refresh(),
              ),
              firstPageProgressIndicatorBuilder: (_) =>
                  FirstPageProgressIndicator(),
              newPageProgressIndicatorBuilder: (_) => const Center(
                  child: CircularProgressIndicator()), // Customize the loader
              noItemsFoundIndicatorBuilder: (_) => SizedBox.shrink(),
              itemBuilder: (context, item, index) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: PageView.builder(
                    itemCount: _pagingController.itemList?.length ?? 0,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final ShortsModel item =
                          _pagingController.itemList![index];
                      final content = item.content != null
                          ? _removeHtmlTags(item.content!)
                          : '';
                      String _formatCreatedAt(String dateString) {
                        try {
                          DateTime dateTime =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                  .parse(dateString, true)
                                  .toLocal();

                          String formattedDate =
                              DateFormat('MMMM d, yyyy').format(dateTime);

                          return formattedDate;
                        } catch (e) {
                          return dateString;
                        }
                      }

                      return Stack(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Center(
                                  child: VideoPlayerWidget(
                                    showFullScreenButton: false,
                                    videoUrl: item.fileUrl ?? '',
                                    showPlay: true,
                                    shimmerWidth: double.infinity,
                                    shimmerHeight: 600.h,
                                    isMuted: isMute,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        GoRouter.of(context).pop();
                                      },
                                      icon: const Icon(
                                          FontAwesomeIcons.chevronLeft)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isMute = !isMute;
                                        });
                                      },
                                      icon: Icon(isMute
                                          ? FontAwesomeIcons.volumeXmark
                                          : FontAwesomeIcons.volumeHigh)),
                                  SizedBox(
                                    width: 116.w,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          FontAwesomeIcons.magnifyingGlass)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          FontAwesomeIcons.ellipsisVertical)),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.barsStaggered,
                                      size: 18.sp,
                                    ), // Custom icon
                                    onPressed: () {
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer(); // Open the drawer
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 170.h,
                              right: 10.w,
                              child: Column(
                                children: [
                                  CustomShortsButton(
                                    icon: FontAwesomeIcons.solidHeart,
                                    text: likes.toString(),
                                    color: isLiked ? Colors.red : Colors.white,
                                    onTap: () {
                                      setState(() {
                                        if (isLiked) {
                                          likes--;
                                          isLiked = false;
                                        } else {
                                          likes++;
                                          isLiked = true;
                                        }
                                      });
                                    },
                                  ),
                                  CustomShortsButton(
                                    icon: FontAwesomeIcons.solidMessage,
                                    text: '${item.commentsCount}',
                                    color: Colors.white,
                                    onTap: () {
                                      shortsCommentBottomSheet(
                                          context, setState);
                                    },
                                  ),
                                  CustomShortsButton(
                                    icon: FontAwesomeIcons.share,
                                    text: 'Share',
                                    color: Colors.white,
                                    onTap: () {
                                      shortsShareBottomSheet(context);
                                    },
                                  ),
                                  CustomShortsButton(
                                    icon: FontAwesomeIcons.solidBookmark,
                                    text: item.saves?.count.toString() ?? '0',
                                    color:
                                        isSaved ? Colors.yellow : Colors.white,
                                    onTap: () {
                                      setState(() {
                                        if (isSaved) {
                                          saves--;
                                          isSaved = false;
                                        } else {
                                          saves++;
                                          isSaved = true;
                                        }
                                      });
                                    },
                                  ),
                                  CustomShortsButton(
                                    icon: FontAwesomeIcons.sackDollar,
                                    text: 'Donate',
                                    color: Colors.white,
                                    onTap: () {
                                      donationBottomSheet(context);
                                    },
                                  ),
                                ],
                              )),
                          Positioned(
                              bottom: 170.h,
                              left: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomUserProfileImage(
                                        image: item.user?.profileImg ?? '',
                                        isActive: true,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextWidget(
                                            maxLines: 4,
                                            text: item.user?.showname ?? '',
                                            textSize: 12.sp,
                                            fontFamily: '',
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                          CustomTextWidget(
                                            maxLines: 4,
                                            text: _formatCreatedAt(
                                                item.createdAt ?? ''),
                                            textSize: 12.sp,
                                            fontFamily: '',
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 280.w,
                                        child: CustomTextWidget(
                                          maxLines: 4,
                                          text: content,
                                          textSize: 12.sp,
                                          fontFamily: '',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ))
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
