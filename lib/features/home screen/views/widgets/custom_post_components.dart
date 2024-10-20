import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';

class CustomPostComponents extends StatelessWidget {
  const CustomPostComponents({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.width,
    required this.isNightMode,
  });
  final IconData icon;
  final String text;
  final Function() onTap;
  final double width;
  final bool isNightMode;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 30.h,
          width: width,
          decoration: BoxDecoration(
              color: ThemeCubit().state == ThemeState.dark
                  ? Colors.black
                  : Colors.white,
              borderRadius: BorderRadius.circular(8.r)),
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
