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
    return Stack(
      alignment: Alignment.center,
      children: [
        // Shadow layer outside the ClipRRect
        Container(
          width: 56.r,
          height: 56.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimaryColor2.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        // Clipped circular button
        ClipRRect(
          borderRadius: BorderRadius.circular(1000.r),
          child: Container(
            width: 56.r,
            height: 56.r,
            color: AppColors.kPrimaryColor2,
            child: isSelected
                ? Icon(
                    FontAwesomeIcons.x,
                    size: 23.r,
                    color: Colors.white,
                  )
                : Icon(
                    FontAwesomeIcons.bars,
                    size: 23.r,
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }
}
