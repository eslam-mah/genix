import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage(
      {super.key,
      required this.image,
      this.width,
      this.height,
      required this.showname});
  final String image;
  final double? width;
  final double? height;

  final String showname;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.w,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: image,
          width: width ?? 30.w,
          height: height ?? 30.w,
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
    );
  }
}
