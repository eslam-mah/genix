import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';

class CustomSupportTicketsHCounter extends StatelessWidget {
  const CustomSupportTicketsHCounter({
    super.key,
    required this.number,
    required this.text,
  });
  final num number;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 90.h,
      decoration: BoxDecoration(
          color: ThemeCubit().state == ThemeState.dark
              ? DarkModeColors.kItemColorDark
              : AppColors.kAppBar2Color,
          borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        children: [
          Container(
            width: 8.w,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r))),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                textSize: 40.sp,
                fontFamily: '',
                fontWeight: FontWeight.bold,
                text: number.toString(),
              ),
              CustomTextWidget(
                textSize: 10.sp,
                fontFamily: '',
                fontWeight: FontWeight.w500,
                text: text,
              )
            ],
          ),
        ],
      ),
    );
  }
}
