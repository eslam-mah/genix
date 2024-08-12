import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';

class PhotosGridView extends StatelessWidget {
  const PhotosGridView({
    super.key,
    required this.height,
    required this.crossAxisCount,
    required this.direction,
    this.profileModel,
  });
  final double height;
  final int crossAxisCount;
  final Axis direction;
  final ProfileModel? profileModel;

  void _showImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: double.infinity,
          height: double.infinity,
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
    final photos = profileModel?.data?.photos ?? [];

    if (photos.isEmpty) {
      return Container();
    }

    return SizedBox(
      height: height,
      child: ListView.builder(
        itemCount: photos.length > 4 ? 4 : photos.length,
        scrollDirection: direction,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: crossAxisCount,
        //   crossAxisSpacing: 10,
        //   mainAxisSpacing: 10,
        //   childAspectRatio: 1,
        // ),
        itemBuilder: (context, index) {
          final photoUrl = photos[index].fileUrl ?? '';
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _showImagePreview(context, photoUrl);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: CachedNetworkImage(
                  imageUrl: photoUrl,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.kLogo,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
