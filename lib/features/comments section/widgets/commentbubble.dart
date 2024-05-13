import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';

import 'package:genix/core/widgets/customuserprofileimage.dart';

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
  like,
  heart,
  none
}

class CustomCommentBubble extends StatefulWidget {
  const CustomCommentBubble({
    super.key,
    required this.onTap,
    required this.commentText,
  });
  final Function() onTap;
  final String commentText;
  @override
  State<CustomCommentBubble> createState() => _CustomCommentBubbleState();
}

class _CustomCommentBubbleState extends State<CustomCommentBubble> {
  Reaction reaction = Reaction.none;
  bool reactionView = false;
  bool isReacted = false;
  int reactNum = 0;

  final List<dynamic> reactions = [
    ReactionElement2(
        Image.asset(AppGifs.kLikeReact, height: 30.h), Reaction.like),
    ReactionElement2(
        Image.asset(AppGifs.kHeartReact, height: 30.h), Reaction.heart),
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
        Column(
          children: [
            Row(
              children: [
                const CustomUserProfileImage(),
                SizedBox(width: 15.w),
                Flexible(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.kAppBar2Color,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Name'),
                              Text('1 day ago'),
                            ],
                          ),
                          Text(
                            widget.commentText,
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(width: 60.w),
                InkWell(
                    onTap: () {
                      if (reactionView) {
                        reactionView = false;
                      } else {
                        if (reaction == Reaction.none) {
                          reaction = Reaction.like;
                          reactNum++;
                          isReacted = true;
                        } else {
                          reaction = Reaction.none;
                          if (reactNum > 0) {
                            reactNum--;
                          }
                          isReacted = false;
                        }
                      }
                      setState(() {});
                    },
                    onLongPress: () {
                      setState(() {
                        reactionView = true;
                      });
                    },
                    child: getReactionText(reaction)),
                SizedBox(width: 30.w),
                InkWell(onTap: widget.onTap, child: const Text('Reply'))
              ],
            ),
          ],
        ),
        if (reactionView)
          Positioned(
            bottom: 20.h,
            left: 50.w,
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
                              isReacted = reaction != Reaction.none;
                            });
                          },
                          icon: reactions[index].image,
                        )),
                      ),
                    );
                  },
                )),
          ),
        if (isReacted)
          Positioned(
              bottom: 25,
              right: 20,
              child: Container(
                width: 50.w,
                height: 20.h,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 232, 232),
                    borderRadius: BorderRadius.circular(10.r)),
                child: getReactionIcon(reaction),
              ))
      ],
    );
  }

  Widget getReactionIcon(Reaction r) {
    switch (r) {
      case Reaction.cry:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kCry), Text('$reactNum')],
        );
      case Reaction.cute:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kCute), Text('$reactNum')],
        );
      case Reaction.angry:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kAngryReact), Text('$reactNum')],
        );
      case Reaction.laugh:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kLaughReact), Text('$reactNum')],
        );
      case Reaction.sad:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kSadReact), Text('$reactNum')],
        );
      case Reaction.surprise:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kWowReact), Text('$reactNum')],
        );
      case Reaction.wink:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kWinkReact), Text('$reactNum')],
        );
      case Reaction.like:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(AppGifs.kLikeReact, height: 15.h),
            Text('$reactNum'),
          ],
        );
      case Reaction.heart:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(AppGifs.kHeartReact, height: 15.h),
            Text('$reactNum')
          ],
        );
      case Reaction.love:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLotties.kLove), Text('$reactNum')],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget getReactionText(Reaction r) {
    switch (r) {
      case Reaction.cry:
        return const Text(
          'Cry',
          style: TextStyle(color: Colors.blue),
        );
      case Reaction.cute:
        return const Text(
          'Cute',
          style: TextStyle(color: Colors.blue),
        );
      case Reaction.angry:
        return const Text(
          'Angry',
          style: TextStyle(color: Colors.blue),
        );
      case Reaction.laugh:
        return const Text(
          'Laugh',
          style: TextStyle(color: Colors.blue),
        );
      case Reaction.sad:
        return const Text(
          'Sad',
          style: TextStyle(color: Colors.blue),
        );
      case Reaction.surprise:
        return const Text(
          'Surprise',
          style: TextStyle(color: Colors.blue),
        );
      case Reaction.wink:
        return const Text(
          'Wink',
          style: TextStyle(color: Colors.blue),
        );
      case Reaction.like:
        return const Text(
          'Like',
          style: TextStyle(color: Colors.blue),
        );
      case Reaction.heart:
        return const Text(
          'Heart',
          style: TextStyle(color: Colors.blue),
        );

      case Reaction.love:
        return const Text(
          'Love',
          style: TextStyle(color: Colors.blue),
        );
      default:
        return const Text(
          'Like',
          style: TextStyle(color: Colors.black),
        );
    }
  }
}

class ReactionElement {
  final Reaction reaction;
  final LottieBuilder image;
  ReactionElement(this.image, this.reaction);
}

class ReactionElement2 {
  final Reaction reaction;
  final Image image;
  ReactionElement2(this.image, this.reaction);
}
