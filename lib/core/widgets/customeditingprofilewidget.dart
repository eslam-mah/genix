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
  });
  final String imageUrl;
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
    return Stack(
      children: [
        ClipOval(
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
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.kLogo,
                    ),
                  );
                },
                imageUrl: imageUrl,
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
