import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/video_player_page.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

class VideoPost extends StatelessWidget {
  final PostsModel postsModel;
  const VideoPost({super.key, required this.postsModel});

  @override
  Widget build(BuildContext context) {
    final uploads = postsModel.uploads;
    final user = postsModel.user;
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
                crossAxisCount: uploads.length,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1,
              ),
              itemCount: uploads.length,
              itemBuilder: (context, index) {
                final upload = uploads[index];
                return VideoPlayerWidget(
                  videoUrl: upload.fileUrl,
                  showPlay: true,
                  shimmerWidth: 0,
                  shimmerHeight: 0,
                  isMuted: true,
                  played: false,
                  showLoadingIndicator: true,
                );
              },
            ),
    );
  }
}
