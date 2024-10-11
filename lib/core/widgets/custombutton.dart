import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    required this.buttonText,
    this.width,
    required this.height,
    required this.borderRadius,
    required this.onTap,
    this.icon,
  });
  final Color? color;
  final String buttonText;
  final double? width;
  final double height;
  final double borderRadius;
  final Function() onTap;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(borderRadius)),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(
                  width: 10.w,
                ),
              ],
              Text(
                buttonText,
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
