import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';

class CustomSmallUserProfileImage extends StatelessWidget {
  const CustomSmallUserProfileImage(
      {super.key, required this.image, required this.isActive, r});
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
              width: 20.w,
              height: 20.w,
              fit: BoxFit.fill,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  width: 0.w,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.kLogo,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
