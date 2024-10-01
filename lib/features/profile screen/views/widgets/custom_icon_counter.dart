import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCounterIcon extends StatelessWidget {
  const CustomCounterIcon({
    super.key,
    required this.icon,
    required this.number,
  });
  final IconData icon;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 10.h),
      child: SizedBox(
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20.r,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              '$number',
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
