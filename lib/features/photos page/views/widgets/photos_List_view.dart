import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';

class PhotosGridView extends StatelessWidget {
  const PhotosGridView({
    super.key,
    this.profileModel,
  });

  final ProfileModel? profileModel;

  void _openImageDialog(BuildContext context, String imageUrl) {
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

  @override
  Widget build(BuildContext context) {
    final photos = profileModel?.data?.photos ?? [];

    if (photos.isEmpty) {
      return Container();
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: photos.length > 4 ? 4 : photos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.w,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final photoUrl = photos[index].fileUrl ?? '';
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _openImageDialog(context, photoUrl);
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
    );
  }
}
