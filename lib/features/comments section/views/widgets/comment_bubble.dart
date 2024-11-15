import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/features/comments%20section/data/models/comments_model.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:html/parser.dart' show parse;
import 'package:timeago/timeago.dart' as timeago;

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

class CustomCommentBubble extends StatefulWidget {
  const CustomCommentBubble({
    super.key,
    required this.onTap,
    // required this.commentText,
    required this.postsModel,
  });
  final Function() onTap;
  // final String commentText;
  final Comment postsModel;
  @override
  State<CustomCommentBubble> createState() => _CustomCommentBubbleState();
}

class _CustomCommentBubbleState extends State<CustomCommentBubble> {
  Reaction reaction = Reaction.none;
  bool reactionView = false;
  bool isReacted = false;
  int reactNum = 0;
  String _removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  final List<dynamic> reactions = [
    ReactionElement(Lottie.asset(AppLottie.kLaughReact), Reaction.laugh),
    ReactionElement(Lottie.asset(AppLottie.kSadReact), Reaction.sad),
    ReactionElement(Lottie.asset(AppLottie.kWowReact), Reaction.surprise),
    ReactionElement(Lottie.asset(AppLottie.kCry), Reaction.cry),
    ReactionElement(Lottie.asset(AppLottie.kLove), Reaction.love),
    ReactionElement(Lottie.asset(AppLottie.kAngryReact), Reaction.angry),
    ReactionElement(Lottie.asset(AppLottie.kWinkReact), Reaction.wink),
    ReactionElement(Lottie.asset(AppLottie.kCute), Reaction.cute),
  ];
  @override
  Widget build(BuildContext context) {
    final content = widget.postsModel.content != null
        ? _removeHtmlTags(widget.postsModel.content!)
        : '';
    if (widget.postsModel.user == null || widget.postsModel.content == null) {
      return Container();
    }
    final relativeTime =
        timeago.format(widget.postsModel.createdAt ?? DateTime.now());
    final replies = widget.postsModel.commentId;
    return Stack(
      children: replies != null
          ? [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 60.w),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(ProfilePage.route,
                              extra: widget.postsModel.user?.username);
                        },
                        child: CustomUserProfileImage(
                          image: widget.postsModel.user?.profileImg ?? '',
                          isActive: widget.postsModel.user?.isActive ?? false,
                          showname: widget.postsModel.user?.showname ?? '',
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: ThemeCubit().state == ThemeState.dark
                                  ? Colors.black
                                  : AppColors.kAppBar2Color,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              GoRouter.of(context).push(
                                                  ProfilePage.route,
                                                  extra: widget.postsModel.user
                                                      ?.username);
                                            },
                                            child: CustomTextWidget(
                                              width: 70.w,
                                              maxLines: 3,
                                              textSize: 12.sp,
                                              fontFamily: '',
                                              fontWeight: FontWeight.bold,
                                              text: widget.postsModel.user
                                                      ?.showname ??
                                                  '',
                                            ),
                                          ),
                                          if (widget.postsModel.user!
                                                  .isVerified ==
                                              true)
                                            Image.asset(
                                              AppGifs.kVerified,
                                              width: 20.w,
                                            ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      relativeTime,
                                      style: TextStyle(fontSize: 12.sp),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                if (content.isEmpty)
                                  Image.asset(
                                    AppImages.kLogo,
                                    width: 20.r,
                                  ),
                                Text(
                                  content,
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
                      SizedBox(width: 120.w),
                      InkWell(
                          onTap: () {
                            if (reactionView) {
                              reactionView = false;
                            } else {
                              if (reaction == Reaction.none) {
                                reaction = Reaction.love;
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
                      InkWell(
                          onTap: widget.onTap,
                          child: Text(
                            'Reply',
                            style: TextStyle(fontSize: 12.sp),
                          ))
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
            ]
          : [
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(ProfilePage.route,
                              extra: widget.postsModel.user?.username);
                        },
                        child: CustomUserProfileImage(
                            image: widget.postsModel.user?.profileImg ?? '',
                            showname: widget.postsModel.user?.showname ?? '',
                            isActive:
                                widget.postsModel.user?.isActive ?? false),
                      ),
                      SizedBox(width: 15.w),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: ThemeCubit().state == ThemeState.dark
                                  ? Colors.black
                                  : AppColors.kAppBar2Color,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              GoRouter.of(context).push(
                                                  ProfilePage.route,
                                                  extra: widget.postsModel.user
                                                      ?.username);
                                            },
                                            child: CustomTextWidget(
                                              maxLines: 3,
                                              textSize: 12.sp,
                                              fontFamily: '',
                                              fontWeight: FontWeight.bold,
                                              text: widget.postsModel.user
                                                      ?.showname ??
                                                  '',
                                            ),
                                          ),
                                          if (widget.postsModel.user!
                                                  .isVerified ==
                                              true)
                                            Image.asset(
                                              AppGifs.kVerified,
                                              width: 20.w,
                                            ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      relativeTime,
                                      style: TextStyle(fontSize: 12.sp),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                if (content.isEmpty)
                                  Image.asset(
                                    AppImages.kLogo,
                                    width: 20.r,
                                  ),
                                Text(
                                  content,
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
                                reaction = Reaction.love;
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
          children: [Lottie.asset(AppLottie.kCry), Text('$reactNum')],
        );
      case Reaction.cute:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kCute), Text('$reactNum')],
        );
      case Reaction.angry:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kAngryReact), Text('$reactNum')],
        );
      case Reaction.laugh:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kLaughReact), Text('$reactNum')],
        );
      case Reaction.sad:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kSadReact), Text('$reactNum')],
        );
      case Reaction.surprise:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kWowReact), Text('$reactNum')],
        );
      case Reaction.wink:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kWinkReact), Text('$reactNum')],
        );

      case Reaction.love:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kLove), Text('$reactNum')],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget getReactionText(Reaction r) {
    switch (r) {
      case Reaction.cry:
        return Text(
          'Cry',
          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
        );
      case Reaction.cute:
        return Text(
          'Cute',
          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
        );
      case Reaction.angry:
        return Text(
          'Angry',
          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
        );
      case Reaction.laugh:
        return Text(
          'Laugh',
          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
        );
      case Reaction.sad:
        return Text(
          'Sad',
          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
        );
      case Reaction.surprise:
        return Text(
          'Surprise',
          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
        );
      case Reaction.wink:
        return Text(
          'Wink',
          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
        );

      case Reaction.love:
        return Text(
          'Love',
          style: TextStyle(fontSize: 12.sp, color: Colors.blue),
        );
      default:
        return Text(
          'Like',
          style: TextStyle(fontSize: 12.sp),
        );
    }
  }
}

class ReactionElement {
  final Reaction reaction;
  final LottieBuilder image;
  ReactionElement(this.image, this.reaction);
}
