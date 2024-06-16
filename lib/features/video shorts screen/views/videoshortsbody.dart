import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view/customdrawerwidget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/core/widgets/videoplayerpage.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/addvideobottomsheet.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/donationsbottomsheet.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/shortscommentsbottomsheet.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/customaddbutton.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/customshortsbutton.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/shortsbottomappbar.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/shortssharebottomsheet.dart';
import 'package:go_router/go_router.dart';

class VideoShortsBody extends StatefulWidget {
  const VideoShortsBody({super.key});

  @override
  State<VideoShortsBody> createState() => _VideoShortsBodyState();
}

class _VideoShortsBodyState extends State<VideoShortsBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isNightModeEnabled = false;
  int likes = 0;
  bool isLiked = false;
  int saves = 0;
  bool isSaved = false;

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawerWidget(
        onNightModeChanged: handleNightModeChanged,
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
              child: GestureDetector(
                onTap: () {
                  addVideoBottomSheet(context);
                },
                child: const CustomAddButton(),
              ))
        ],
      )),
      body: SafeArea(
        child: PageView.builder(
          itemCount: 10,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Scaffold(
              backgroundColor: Colors.blue,
              body: Stack(
                children: [
                  Center(child: Image.asset(AppImages.kPost)),
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              icon: const Icon(FontAwesomeIcons.chevronLeft)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.volumeXmark)),
                          SizedBox(
                            width: 116.w,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(FontAwesomeIcons.magnifyingGlass)),
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
                      bottom: 30,
                      right: 10,
                      child: Column(
                        children: [
                          CustomShortsButton(
                            icon: FontAwesomeIcons.solidHeart,
                            text: likes.toString(),
                            color: isLiked ? Colors.red : Colors.white,
                            onTap: () {
                              if (isLiked) {
                                setState(() {
                                  likes--;
                                  isLiked = false;
                                });
                              } else {
                                setState(() {
                                  likes++;
                                  isLiked = true;
                                });
                              }
                            },
                          ),
                          CustomShortsButton(
                            icon: FontAwesomeIcons.solidMessage,
                            text: '0',
                            color: Colors.white,
                            onTap: () {
                              shortsCommentBottomSheet(context, setState);
                            },
                          ),
                          CustomShortsButton(
                            icon: FontAwesomeIcons.share,
                            text: '0',
                            color: Colors.white,
                            onTap: () {
                              shortsShareBottomSheet(context);
                            },
                          ),
                          CustomShortsButton(
                            icon: FontAwesomeIcons.solidBookmark,
                            text: saves.toString(),
                            color: isSaved ? Colors.yellow : Colors.white,
                            onTap: () {
                              if (isSaved) {
                                setState(() {
                                  saves--;
                                  isSaved = false;
                                });
                              } else {
                                setState(() {
                                  saves++;
                                  isSaved = true;
                                });
                              }
                            },
                          ),
                          CustomShortsButton(
                            icon: FontAwesomeIcons.sackDollar,
                            text: '0',
                            color: Colors.white,
                            onTap: () {
                              donationBottomSheet(context);
                            },
                          ),
                        ],
                      )),
                  Positioned(
                      bottom: 25,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CustomUserProfileImage(),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('data'), Text('6 views')],
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
                              const Text('datassssssssssssssssssssssss'),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
