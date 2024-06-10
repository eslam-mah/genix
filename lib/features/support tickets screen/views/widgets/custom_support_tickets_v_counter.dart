import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customtextwidget.dart';

class CustomSupportTicketsVCounter extends StatelessWidget {
  const CustomSupportTicketsVCounter({
    super.key,
    required this.text,
    required this.icon,
    required this.title,
    required this.buttonText,
    required this.buttonIcon,
  });
  final IconData icon;
  final String title;
  final String text;
  final String buttonText;
  final String buttonIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 250.h,
      decoration: BoxDecoration(
          color: AppColors.kAppBar2Color,
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        //    mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 25.r,
                ),
                CustomTextWidget(
                  textSize: 40.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  text: title,
                ),
                CustomTextWidget(
                    textSize: 10.sp,
                    fontFamily: '',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    text: text)
              ],
            ),
          ),
          Container(
            height: 8.h,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r))),
          ),
        ],
      ),
    );
  }
}
