import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';

class ShareByWidget extends StatelessWidget {
  const ShareByWidget({
    super.key,
    required this.typeSelected,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final int typeSelected;
  final int isSelected;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: 157.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: ThemeCubit().state == ThemeState.dark
              ? DarkModeColors.kItemColorDark
              : AppColors.kTextFieldColor,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.5),
              blurRadius: isSelected == typeSelected ? 6 : 0,
            ),
          ],
          border: Border.all(
            color: isSelected == typeSelected
                ? Colors.green
                : Colors.black.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: Colors.green),
            Text(
              text,
              style: TextStyle(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
