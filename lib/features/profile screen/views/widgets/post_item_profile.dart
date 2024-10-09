import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/features/comments%20section/views/view/commentsbody.dart';

import 'package:genix/features/home%20screen/views/widgets/custom_post_components.dart';
import 'package:genix/features/home%20screen/views/widgets/share_bottom_sheet.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:html/parser.dart' show parse;

enum Reaction { cry, cute, angry, laugh, love, sad, surprise, wink, none }

class PostItemProfile extends StatefulWidget {
  const PostItemProfile({
    super.key,
    required this.isNightModeEnabled,
    required this.profileModel,
    required this.index,
  });
  final bool isNightModeEnabled;
  final ProfileModel profileModel;
  final int index;

  @override
  State<PostItemProfile> createState() => _PostItemProfileState();
}

class _PostItemProfileState extends State<PostItemProfile> {
  Reaction reaction = Reaction.none;
  bool reactionView = false;
  bool isVideo = false;
  bool isPoll = false;
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

  void _showImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: double.infinity,
          height: 520.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.profileModel.data?.user;
    final recentPost = widget.profileModel.data?.recentPosts?[widget.index];
    final uploads = recentPost?.uploads;
    final content = recentPost?.content != null
        ? _removeHtmlTags(recentPost?.content ?? '')
        : '';

    if (user == null || uploads == null || uploads.isEmpty) {
      return Container(); // Return an empty container or a placeholder if the data is invalid
    }

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
                      CustomUserProfileImage(
                        image: user.profileImg ?? '',
                        isActive: user.isActive ?? false,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(user.showname ?? 'Unknown User'),
                                if (user.isVerified == true)
                                  Image.asset(
                                    AppGifs.kVerified,
                                    width: 20.w,
                                  ),
                              ],
                            ),
                            if (recentPost?.createdAt != null)
                              Text(DateFormat('MMMM d, yyyy').format(
                                  recentPost?.createdAt ?? DateTime.now())),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // showPostTabBar(context, widget.isNightModeEnabled);
                        },
                        icon: const Icon(FontAwesomeIcons.ellipsis),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  recentPost?.content != null
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextWidget(
                                textSize: 15.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.normal,
                                text: content,
                              ),
                            ),
                            SizedBox(height: 7.h),
                          ],
                        )
                      : const SizedBox.shrink(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: uploads.length == 1
                        ? GestureDetector(
                            onTap: () {
                              _showImagePreview(context, uploads.first.fileUrl);
                            },
                            child: CachedNetworkImage(
                              imageUrl: uploads.first.fileUrl,
                              width: double.infinity,
                              height: 200.h,
                              fit: BoxFit.cover,
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: uploads.length,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              childAspectRatio: 1,
                            ),
                            itemCount: uploads.length,
                            itemBuilder: (context, index) {
                              final upload = uploads[index];
                              return GestureDetector(
                                onTap: () {
                                  _showImagePreview(context, upload.fileUrl);
                                },
                                child: CachedNetworkImage(
                                  imageUrl: upload.fileUrl,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(height: 4.h),
                  Divider(color: Colors.white),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12.r,
                        child:
                            Lottie.asset(AppLottie.kAngryReact, height: 405.h),
                      ),
                      SizedBox(width: 3.w),
                      SizedBox(
                        width: 30.w,
                        child: Text(
                          ' $reactNum',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      Icon(FontAwesomeIcons.solidComment, size: 11.sp),
                      SizedBox(width: 9.w),
                      SizedBox(
                          width: recentPost?.commentsCount?.toDouble(),
                          child: Text("${recentPost?.commentsCount ?? 0}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.sp))),
                      SizedBox(width: 9.w),
                      Text('Comments', style: TextStyle(fontSize: 11.sp)),
                      SizedBox(width: 9.w),
                      Icon(FontAwesomeIcons.share, size: 11.sp),
                      SizedBox(width: 9.w),
                      SizedBox(
                          width: recentPost?.sharesCount?.toDouble(),
                          child: Text("${recentPost?.sharesCount ?? 0}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.sp))),
                      SizedBox(width: 9.w),
                      Text('Shares', style: TextStyle(fontSize: 11.sp)),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (reaction == Reaction.none) {
                              reaction = Reaction.love;
                              reactNum++;
                            } else {
                              reaction = Reaction.none;
                              if (reactNum > 0) reactNum--;
                            }
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            reactionView = true;
                          });
                        },
                        child: Container(
                          height: 30.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: _getReactionIcon(reaction),
                        ),
                      ),
                      CustomPostComponents(
                        icon: FontAwesomeIcons.solidComment,
                        width: 90.w,
                        text: 'Comment',
                        isNightMode: widget.isNightModeEnabled,
                        onTap: () {
                          GoRouter.of(context).push(CommentsBody.routeName,
                              extra: widget.profileModel);
                        },
                      ),
                      CustomPostComponents(
                        icon: FontAwesomeIcons.share,
                        width: 90.w,
                        text: 'Share',
                        isNightMode: widget.isNightModeEnabled,
                        onTap: () {
                          shareBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                borderRadius: BorderRadius.circular(50.r),
              ),
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
                                if (reaction != Reaction.none) reactNum--;
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
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _getReactionIcon(Reaction r) {
    switch (r) {
      case Reaction.cry:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kCry), const Text('Cry')],
        );
      case Reaction.cute:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kCute), const Text('Cute')],
        );
      case Reaction.angry:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kAngryReact), const Text('Angry')],
        );
      case Reaction.laugh:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kLaughReact), const Text('HAHA')],
        );
      case Reaction.sad:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kSadReact), const Text('Sad')],
        );
      case Reaction.surprise:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kWowReact), const Text('Surprise')],
        );
      case Reaction.wink:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kWinkReact), const Text('Wink')],
        );
      case Reaction.love:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Lottie.asset(AppLottie.kLove), const Text('Love')],
        );
      default:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(FontAwesomeIcons.solidHeart),
            Text('Like'),
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
