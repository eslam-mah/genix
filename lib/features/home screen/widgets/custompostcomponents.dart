import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPostComponents extends StatelessWidget {
  const CustomPostComponents({
    super.key,
    required this.icon,
    required this.text,
    required this.ontap,
  });
  final IconData icon;
  final String text;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: Container(
          height: 30.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 18.sp,
              ),
              Text(text)
            ],
          ),
        ));
  }
}
