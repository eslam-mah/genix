import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconProfileButton extends StatelessWidget {
  const CustomIconProfileButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon),
              SizedBox(
                height: 5.h,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 10.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
