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
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/custom_post_components.dart';
import 'package:genix/features/home%20screen/views/widgets/share_bottom_sheet.dart';
import 'package:genix/features/home%20screen/views/widgets/show_post_tabbar_dialoge.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:html/parser.dart' show parse;
import 'package:url_launcher/url_launcher.dart';

enum Reaction { cry, cute, angry, laugh, love, sad, surprise, wink, none }

class LinkPostItem extends StatefulWidget {
  const LinkPostItem({
    super.key,
    required this.isNightModeEnabled,
    required this.postsModel,
  });
  final bool isNightModeEnabled;
  final PostsModel postsModel;

  @override
  State<LinkPostItem> createState() => _LinkPostItemState();
}

class _LinkPostItemState extends State<LinkPostItem> {
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
    final user = widget.postsModel.user;

    final content = widget.postsModel.content != null
        ? _removeHtmlTags(widget.postsModel.content!)
        : '';
    if (user == null) {
      return Container();
    }
    Future<void> launchUrl(String urlString) async {
      if (await canLaunch(urlString)) {
        await launch(urlString);
      } else {
        throw 'Could not launch $urlString';
      }
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
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(ProfilePage.route,
                              extra: widget.postsModel);
                        },
                        borderRadius: BorderRadius.circular(400.r),
                        child: CustomUserProfileImage(
                          image: user.profileImg ?? '',
                          isActive: user.isActive ?? false,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(user.showname ?? 'Unknown User'),
                                if (widget.postsModel.user!.isVerified == true)
                                  Image.asset(
                                    AppGifs.kVerified,
                                    width: 20.w,
                                  ),
                              ],
                            ),
                            if (user.createdAt != null)
                              Text(DateFormat('MMMM d, yyyy')
                                  .format(widget.postsModel.createdAt!))
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showPostTabBar(context, widget.isNightModeEnabled);
                        },
                        icon: const Icon(FontAwesomeIcons.ellipsis),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  widget.postsModel.content != null
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  launchUrl(widget.postsModel.ogInfo?.url ??
                                      'https://www.google.com/');
                                },
                                child: CustomTextWidget(
                                    textSize: 15.sp,
                                    fontFamily: '',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.blue,
                                    text: content),
                              ),
                            ),
                            SizedBox(height: 7.h),
                          ],
                        )
                      : const SizedBox.shrink(),
                  InkWell(
                    onTap: () {
                      launchUrl(widget.postsModel.ogInfo?.url ??
                          'https://www.google.com/');
                    },
                    borderRadius: BorderRadius.circular(10.r),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white.withOpacity(0.3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CachedNetworkImage(
                                  width: 100.r,
                                  imageUrl:
                                      widget.postsModel.ogInfo?.image ?? ''),
                              SizedBox(
                                width: 210.w,
                                height: 55.h,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                        textSize: 12.sp,
                                        fontFamily: '',
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        text: widget
                                                .postsModel.ogInfo?.siteName ??
                                            ''),
                                    CustomTextWidget(
                                        textSize: 12.sp,
                                        fontFamily: '',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        text: widget.postsModel.ogInfo?.title ??
                                            ''),
                                    CustomTextWidget(
                                        textSize: 12.sp,
                                        fontFamily: '',
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        text:
                                            widget.postsModel.ogInfo?.url ?? '')
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(height: 4.h),
                  Divider(color: Colors.white),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12.r,
                        child:
                            Lottie.asset(AppLotties.kAngryReact, height: 405.h),
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
                          width: widget.postsModel.commentsCount!.toDouble(),
                          child: Text("${widget.postsModel.commentsCount}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.sp))),
                      SizedBox(width: 9.w),
                      Text('Comments', style: TextStyle(fontSize: 11.sp)),
                      SizedBox(width: 9.w),
                      Icon(FontAwesomeIcons.share, size: 11.sp),
                      SizedBox(width: 9.w),
                      SizedBox(
                          width: widget.postsModel.sharesCount!.toDouble(),
                          child: Text("${widget.postsModel.sharesCount}",
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
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: _getReactionIcon(reaction),
                        ),
                      ),
                      CustomPostComponents(
                        icon: FontAwesomeIcons.solidComment,
                        width: 100.w,
                        text: 'Comment',
                        ontap: () {
                          GoRouter.of(context).push(CommentsBody.routeName,
                              extra: widget.postsModel);
                        },
                      ),
                      CustomPostComponents(
                        icon: FontAwesomeIcons.share,
                        width: 100.w,
                        text: 'Share',
                        ontap: () {
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
