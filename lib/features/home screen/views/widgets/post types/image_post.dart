import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

class ImagePost extends StatelessWidget {
  final PostsModel postsModel;
  const ImagePost({super.key, required this.postsModel});

  @override
  Widget build(BuildContext context) {
    final uploads = postsModel.uploads;
    final user = postsModel.user;
    if (user == null || uploads == null || uploads.isEmpty) {
      return Container(); // Return an empty container or a placeholder if the data is invalid
    }
    bool isEven(int number) {
      if (number % 2 == 0) {
        return true;
      } else {
        return false;
      }
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: uploads.length == 1
          ? InkWell(
              onTap: () {
                openImageDialog(context, uploads.first.fileUrl);
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
                return InkWell(
                  onTap: () {
                    openImageDialog(context, upload.fileUrl);
                  },
                  child: CachedNetworkImage(
                    imageUrl: upload.fileUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}
