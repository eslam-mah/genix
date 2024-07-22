import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';

class CustomUserProfileImage extends StatelessWidget {
  const CustomUserProfileImage({
    super.key,
    required this.image,
    required this.isActive,
  });
  final String image;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: image,
              width: 40.w,
              fit: BoxFit.cover,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.kLogo,
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
            bottom: 4.h,
            right: 1.w,
            child: isActive
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 5.5,
                  )
                : SizedBox.shrink()),
        Positioned(
            bottom: 5.h,
            right: 2.w,
            child: isActive
                ? CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 4,
                  )
                : SizedBox.shrink())
      ],
    );
  }
}
