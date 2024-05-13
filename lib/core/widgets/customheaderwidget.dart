import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 60.h,
          decoration: const BoxDecoration(color: AppColors.kPrimaryColor2),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: Image.asset(AppImages.kWhiteLogo2)),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Positioned(
          child: Opacity(
            opacity: 0.08,
            child: SizedBox(
                height: 60.h,
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.kHeaderImage,
                      width: 120.w,
                    ),
                    Image.asset(
                      AppImages.kHeaderImage,
                      width: 120.w,
                    ),
                    Image.asset(
                      AppImages.kHeaderImage,
                      width: 120.w,
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
