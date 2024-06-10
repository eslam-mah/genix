import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSmallUserProfileImage extends StatelessWidget {
  const CustomSmallUserProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 10.r,
          backgroundColor: Colors.purple,
          child: Text(
            '',
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        ),
        Positioned(
            bottom: 2.h,
            right: 1.w,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 2.r,
            )),
        Positioned(
            bottom: 3.h,
            right: 2.w,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 1.r,
            ))
      ],
    );
  }
}
