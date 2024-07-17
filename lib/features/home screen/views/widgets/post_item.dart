import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';

import 'package:genix/features/home%20screen/views/widgets/custom_post_components.dart';
import 'package:genix/features/home%20screen/views/widgets/share_bottom_sheet.dart';
import 'package:genix/features/home%20screen/views/widgets/show_post_tabbar_dialoge.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

enum Reaction {
  cry,
  cute,
  angry,
  laugh,
  love,
  sad,
  surprise,
  wink,

  none
}

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.isNightModeEnabled,
  });
  final bool isNightModeEnabled;
  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Reaction reaction = Reaction.none;
  bool reactionView = false;
  bool isVideo = false;
  bool isPoll = false;
  int reactNum = 0;
  final List<dynamic> reactions = [
    ReactionElement(Lottie.asset(AppLotties.kLaughReact), Reaction.laugh),
    ReactionElement(Lottie.asset(AppLotties.kSadReact), Reaction.sad),
    ReactionElement(Lottie.asset(AppLotties.kWowReact), Reaction.surprise),
    ReactionElement(Lottie.asset(AppLotties.kCry), Reaction.cry),
    ReactionElement(Lottie.asset(AppLotties.kLove), Reaction.love),
    ReactionElement(Lottie.asset(AppLotties.kAngryReact), Reaction.angry),
    ReactionElement(Lottie.asset(AppLotties.kWinkReact), Reaction.wink),
    ReactionElement(Lottie.asset(AppLotties.kCute), Reaction.cute),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: AppColors.kPostColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CustomUserProfileImage(),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('Name'), Text('Time posted')],
                        ),
                        SizedBox(
                          width: 156.w,
                        ),
                        IconButton(
                            onPressed: () {
                              showPostTabBar(
                                  context, widget.isNightModeEnabled);
                            },
                            icon: const Icon(FontAwesomeIcons.ellipsis))
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.asset(AppImages.kPost),
                      // VideoPlayerWidget()
                      // : Image.asset(AppImages.kPost)
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      width: 290.w,
                      height: 1.h,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12.r,
                          child: Lottie.asset(
                            AppLotties.kAngryReact,
                            height: 405.h,
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        SizedBox(
                            width: 30.w,
                            child: Text(
                              ' $reactNum',
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(
                          width: 90.w,
                        ),
                        Icon(
                          FontAwesomeIcons.solidComment,
                          size: 11.sp,
                        ),
                        SizedBox(
                          width: 25.w,
                          child: Text(
                            '100000',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ),
                        Text(
                          'Comments',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11.sp),
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Icon(
                          FontAwesomeIcons.share,
                          size: 11.sp,
                        ),
                        SizedBox(
                          width: 26.w,
                          child: Text(
                            '1000000',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ),
                        Text(
                          'shares',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                                onTap: () {
                                  if (reactionView) {
                                    reactionView = false;
                                  } else {
                                    if (reaction == Reaction.none) {
                                      reaction = Reaction.love;
                                      reactNum++;
                                    } else {
                                      reaction = Reaction.none;
                                      if (reactNum > 0) {
                                        reactNum--;
                                      }
                                    }
                                  }
                                  setState(() {});
                                },
                                onLongPress: () {
                                  setState(() {
                                    reactionView = true;
                                  });
                                },
                                child: Container(
                                    height: 30.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: getReactionIcon(reaction))),
                          ],
                        ),
                        CustomPostComponents(
                          icon: FontAwesomeIcons.solidComment,
                          text: 'Comment',
                          ontap: () {
                            GoRouter.of(context).push(Rout.kComments);
                          },
                        ),
                        CustomPostComponents(
                          icon: FontAwesomeIcons.share,
                          text: 'Share',
                          ontap: () {
                            shareBottomSheet(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
        if (reactionView)
          Positioned(
            bottom: 60.h,
            left: 30.w,
            child: Container(
                height: 60.h,
                width: 300.w,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50.r)),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: reactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 15 + index + 15,
                        child: FadeInAnimation(
                            child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (reactionView &&
                                  reaction != reactions[index].reaction) {
                                if (reaction != Reaction.none) {
                                  reactNum--;
                                }
                                reaction = reactions[index].reaction;
                                reactNum++;
                              } else if (reaction ==
                                  reactions[index].reaction) {
                                reaction = Reaction.none;
                                reactNum--;
                              }
                              reactionView = false;
                            });
                          },
                          icon: reactions[index].image,
                        )),
                      ),
                    );
                  },
                )),
          ),
      ],
    );
  }

  Widget getReactionIcon(Reaction r) {
    switch (r) {
      case Reaction.cry:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kCry), const Text('Cry')],
        );
      case Reaction.cute:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kCute), const Text('Cute')],
        );
      case Reaction.angry:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kAngryReact), const Text('Angry')],
        );
      case Reaction.laugh:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kLaughReact), const Text('HAHA')],
        );
      case Reaction.sad:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kSadReact), const Text('Sad')],
        );
      case Reaction.surprise:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset(AppLotties.kWowReact),
            const Text('Surprise')
          ],
        );
      case Reaction.wink:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kWinkReact), const Text('Wink')],
        );

      case Reaction.love:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kLove), const Text('Love')],
        );
      default:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              FontAwesomeIcons.solidHeart,
            ),
            Text('Like')
          ],
        );
    }
  }
}

class ReactionElement {
  final Reaction reaction;
  final LottieBuilder image;
  ReactionElement(this.image, this.reaction);
}
