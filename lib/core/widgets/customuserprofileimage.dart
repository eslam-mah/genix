import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUserProfileImage extends StatelessWidget {
  const CustomUserProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.purple,
          child: Text(
            'RA',
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        ),
        const Positioned(
            bottom: 5,
            right: 1,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 5.5,
            )),
        const Positioned(
            bottom: 6,
            right: 2,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 4,
            ))
      ],
    );
  }
}
