import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/event_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/image_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/link_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/media_item.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/poll_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/video_post.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/localization/all_app_strings.dart';

enum Reaction { cry, cute, angry, laugh, love, sad, surprise, wink, none }

enum PostType { image, video, poll, link, event, short, content, media }

class SharedPost extends StatefulWidget {
  final PostsModel postsModel;
  const SharedPost({super.key, required this.postsModel});

  @override
  State<SharedPost> createState() => _SharedPostState();
}

class _SharedPostState extends State<SharedPost> {
  List<PostType> _determinePostTypes(PostsModel postModel) {
    final List<PostType> postTypes = [];
    bool hasImage = false;
    bool hasVideo = false;

    if (postModel.uploads != null) {
      // Check for images
      if (postModel.uploads!.any((upload) =>
          upload.type == "image/png" ||
          upload.type == "image/jpeg" ||
          upload.type == "image/webp")) {
        hasImage = true;
      }
      // Check for videos
      if (postModel.uploads!.any((upload) =>
          upload.type == 'video/mov' ||
          upload.type == 'video/mp4' ||
          upload.type == 'video/webm' ||
          upload.type == 'video/heic')) {
        hasVideo = true;
      }

      if (hasImage && hasVideo) {
        postTypes.add(PostType.media);
      } else if (hasImage) {
        postTypes.add(PostType.image);
      } else if (hasVideo) {
        postTypes.add(PostType.video);
      }
    }

    if (postModel.misc != null && postModel.misc!.poll != null) {
      postTypes.add(PostType.poll);
    }

    if (postModel.ogInfo != null) {
      postTypes.add(PostType.link);
    }
    if (postModel.isEvent == true) {
      postTypes.add(PostType.event);
    }
    if (postModel.isVideoShort == true) {
      postTypes.add(PostType.short);
    } else {
      postTypes.add(PostType.content);
    }

    return postTypes;
  }

  Widget _getPostType(PostType postType, PostsModel postModel) {
    switch (postType) {
      case PostType.image:
        return ImagePost(postsModel: postModel);
      case PostType.video:
        return VideoPost(postsModel: postModel);
      case PostType.media:
        return MediaPost(postsModel: postModel); // Mixed media post
      case PostType.poll:
        return PollPost(postsModel: postModel);
      case PostType.event:
        return EventPost(postsModel: postModel);
      case PostType.link:
        return LinkPost(postsModel: postModel);
      case PostType.short:
        return  Text('${
            AppStrings.shortvideopost.getString(context)}');
      case PostType.content:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }

  String _removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.postsModel.content != null
        ? _removeHtmlTags(widget.postsModel.content!)
        : '';
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(ProfilePage.route,
                      extra: widget.postsModel.user?.username);
                },
                borderRadius: BorderRadius.circular(400.r),
                child: CustomUserProfileImage(
                  showname: widget.postsModel.user?.showname ?? '',
                  image: widget.postsModel.user?.profileImg ?? '',
                  isActive: widget.postsModel.user?.isActive ?? false,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).push(ProfilePage.route,
                                extra: widget.postsModel.user?.username);
                          },
                          child: CustomTextWidget(
                            textSize: 12.sp,
                            fontFamily: 'fontFamily',
                            color: AppColors.kPrimaryColor,
                            fontWeight: FontWeight.normal,
                            text: widget.postsModel.user?.showname ??
                                'Unknown User',
                          ),
                        ),
                        if (widget.postsModel.user!.isVerified == true)
                          Image.asset(
                            AppGifs.kVerified,
                            width: 20.w,
                          ),
                      ],
                    ),
                    if (widget.postsModel.user!.createdAt != null)
                      Text(DateFormat('MMMM d, yyyy')
                          .format(widget.postsModel.createdAt!))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          if (widget.postsModel.content != null) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: widget.postsModel.ogInfo != null
                    ? () async {
                        if (await canLaunch(
                            widget.postsModel.ogInfo?.url ?? '')) {
                          await launch(widget.postsModel.ogInfo?.url ?? '');
                        } else {
                          throw 'Could not launch ${widget.postsModel.ogInfo?.url ?? ''}';
                        }
                      }
                    : null,
                child: CustomTextWidget(
                  textSize: 15.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.normal,
                  color: widget.postsModel.ogInfo != null ? Colors.blue : null,
                  text: content,
                ),
              ),
            ),
            SizedBox(height: 7.h),
          ],
          _getPostType(
              _determinePostTypes(widget.postsModel).first, widget.postsModel),
        ],
      ),
    );
  }
}
