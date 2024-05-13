import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';

class CustomHeaderWidget2 extends StatelessWidget {
  const CustomHeaderWidget2({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            height: 30.h,
            width: 5.w,
            color: AppColors.kPrimaryColor2,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
