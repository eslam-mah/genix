import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

class CustomGlowingButton extends StatelessWidget {
  const CustomGlowingButton({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimaryColor2.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(1000.r),
          color: AppColors.kPrimaryColor2),
      child: isSelected
          ? Icon(
              FontAwesomeIcons.x,
              size: 18.sp,
              color: Colors.white,
            )
          : const Icon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
    );
  }
}
