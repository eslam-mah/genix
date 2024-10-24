import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/video_player_page.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/video_post_item.dart';

class VideoPost extends StatelessWidget {
  final PostsModel postsModel;
  const VideoPost({super.key, required this.postsModel});

  @override
  Widget build(BuildContext context) {
    final uploads = postsModel.uploads;
    final user = postsModel.user;
    bool isEven(int number) {
      if (number % 2 == 0) {
        return true;
      } else {
        return false;
      }
    }

    if (user == null || uploads == null || uploads.isEmpty) {
      return Container(); // Return an empty container or a placeholder if the data is invalid
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: uploads.length == 1
          ? VideoPlayerWidget(
              videoUrl: uploads.first.fileUrl,
              showPlay: true,
              shimmerWidth: 0,
              played: false,
              showLoadingIndicator: true,
              shimmerHeight: 0,
              isMuted: true,
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: uploads.length > 1
                    ? isEven(uploads.length)
                        ? 2
                        : 3
                    : 1,
                crossAxisSpacing: 1.w,
                mainAxisSpacing: 1.w,
                childAspectRatio: 1,
              ),
              itemCount: uploads.length,
              itemBuilder: (context, index) {
                final upload = uploads[index];
                return VideoPlayerPostItem(
                  video: upload.fileUrl,
                );
              },
            ),
    );
  }
}
