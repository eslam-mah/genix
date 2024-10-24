import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';

class CustomUserProfileImage extends StatelessWidget {
  const CustomUserProfileImage(
      {super.key,
      required this.image,
      required this.isActive,
      this.width,
      this.height,
      this.bottom,
      this.right,
      required this.showname});
  final String image;
  final bool isActive;
  final double? width;
  final double? height;
  final double? bottom;
  final double? right;
  final String showname;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: width,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: image,
              width: width ?? 50.w,
              height: height ?? 50.w,
              fit: BoxFit.cover,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  color: Colors.purple,
                  alignment: Alignment.center,
                  child: Text(showname.split('').take(2).join().toUpperCase(),
                      style: TextStyle(fontSize: 15.sp)),
                );
              },
            ),
          ),
        ),
        Positioned(
            bottom: bottom ?? 5.h,
            right: right ?? 1.w,
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
