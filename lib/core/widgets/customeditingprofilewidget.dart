import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  });
  final double size;
  final double whiteSize;
  final double smallSize;
  final double fontSize;
  final double positionBottom;
  final double positionRight;
  final IconData icon;
  final Function() onTapIcon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ]),
          child: CircleAvatar(
            radius: size,
            backgroundColor: Colors.purple,
            child: Text(
              'RA',
              style: TextStyle(fontSize: fontSize, color: Colors.white),
            ),
          ),
        ),
        // Positioned(
        //     bottom: positionBottom,
        //     right: positionRight,
        //     child: CircleAvatar(
        //       backgroundColor: Colors.white,
        //       radius: whiteSize,
        //     )),
        Positioned(
            bottom: positionBottom,
            right: positionRight,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: smallSize,
              child: Center(
                child: GestureDetector(
                  onTap: onTapIcon,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 12.sp,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
