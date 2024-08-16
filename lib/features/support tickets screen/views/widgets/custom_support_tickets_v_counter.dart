import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customiconbutton.dart';
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
  final IconData buttonIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 250.h,
      decoration: BoxDecoration(
          color: AppColors.kAppBar2Color,
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        //    mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 38.r,
                  color: AppColors.kPrimaryColor,
                ),
                CustomTextWidget(
                  textSize: 20.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  text: title,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: CustomTextWidget(
                      maxLines: 1000,
                      textSize: 12.sp,
                      fontFamily: '',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      text: text),
                ),
                CustomIconButton(
                    icon: buttonIcon,
                    buttonText: buttonText,
                    borderRadius: 8.r,
                    width: 120.w,
                    height: 30.h,
                    color: Colors.grey.withOpacity(0.6),
                    onTap: () {})
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
