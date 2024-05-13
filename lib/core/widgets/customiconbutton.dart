import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.buttonText,
    required this.borderRadius,
    required this.width,
    required this.hieght,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String buttonText;
  final double borderRadius;
  final double width;
  final double hieght;
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: hieght,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 15.sp,
              color: Colors.white,
            ),
            Text(
              buttonText,
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
