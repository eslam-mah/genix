import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/video_post_item.dart';

class MediaPost extends StatelessWidget {
  final PostsModel postsModel;
  const MediaPost({super.key, required this.postsModel});

  @override
  Widget build(BuildContext context) {
    final uploads = postsModel.uploads;
    final user = postsModel.user;
    if (user == null || uploads == null || uploads.isEmpty) {
      return Container(); // Return an empty container or a placeholder if the data is invalid
    }

    void openImageDialog(BuildContext context, String imageUrl) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black,
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
      );
    }

    bool isEven(int number) {
      if (number % 2 == 0) {
        return true;
      } else {
        return false;
      }
    }

    bool isVideo(String fileUrl) {
      return fileUrl.endsWith(".mp4") ||
          fileUrl.endsWith(".mov") ||
          fileUrl.endsWith(".webm") ||
          fileUrl.endsWith(".heic"); // Check for common video extensions
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: uploads.length > 1
              ? isEven(uploads.length)
                  ? 2
                  : 3
              : 1,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1,
        ),
        itemCount: uploads.length,
        itemBuilder: (context, index) {
          final upload = uploads[index];
          if (isVideo(upload.fileUrl)) {
            return VideoPlayerPostItem(
              video: upload.fileUrl,
            );
          } else {
            return InkWell(
              onTap: () {
                openImageDialog(context, upload.fileUrl);
              },
              child: CachedNetworkImage(
                imageUrl: upload.fileUrl,
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
    );
  }
}
