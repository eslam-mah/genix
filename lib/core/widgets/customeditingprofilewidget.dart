import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';

class CustomUserProfileEditingImage extends StatelessWidget {
  const CustomUserProfileEditingImage({
    super.key,
    required this.size,
    required this.smallSize,
    required this.whiteSize,
    required this.fontSize,
    required this.positionBottom,
    required this.positionRight,
    required this.icon,
    required this.onTapIcon,
    required this.imageUrl,
    required this.isProfileEditorShown,
    required this.textPlaceHolder,
  });
  final String imageUrl;
  final Widget textPlaceHolder;
  final double size;
  final double whiteSize;
  final double smallSize;
  final double fontSize;
  final double positionBottom;
  final double positionRight;
  final IconData icon;
  final Function() onTapIcon;
  final bool isProfileEditorShown;
  @override
  Widget build(BuildContext context) {
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
                errorWidget: (context, url, error) => Container(
                    color: Colors.purple,
                    width: 300.w,
                    height: 170.h,
                    child: Center(
                      child: textPlaceHolder,
                    )),
              ),
            ),
          );
        },
      );
    }

    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(200.r),
          onTap: () => openImageDialog(context, imageUrl),
          child: ClipOval(
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: size,
                child: CachedNetworkImage(
                  errorWidget: (context, error, stackTrace) {
                    return Container(
                      color: Colors.purple,
                      alignment: Alignment.center,
                      child: textPlaceHolder,
                    );
                  },
                  imageUrl: imageUrl,
                ),
              ),
            ),
          ),
        ),
        isProfileEditorShown
            ? Positioned(
                bottom: positionBottom,
                right: positionRight,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: smallSize,
                  child: Center(
                    child: InkWell(
                      onTap: onTapIcon,
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                  ),
                ))
            : const SizedBox()
      ],
    );
  }
}
