import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';

class PageShareItem extends StatelessWidget {
  const PageShareItem({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: 157.w,
        height: 40.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.5),
                blurRadius: isSelected ? 6 : 0,
              )
            ],
            border: Border.all(
              color: isSelected ? Colors.green : Colors.black.withOpacity(0.5),
            ),
            color: ThemeCubit().state == ThemeState.dark
                ? DarkModeColors.kItemColorDark
                : AppColors.kTextFieldColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 10,
              child: Image.asset(AppImages.kLogo),
            ),
            Text(
              'page',
              style: TextStyle(fontSize: 15.sp),
            )
          ],
        ),
      ),
    );
  }
}
