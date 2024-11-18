import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import '../../../../core/localization/all_app_strings.dart';

class CustomBillingWidget extends StatelessWidget {
  const CustomBillingWidget({
    super.key,
    required this.isSelected,
    required this.numberSelected,
    required this.amount,
    required this.isNightModeEnabled,
  });

  final int isSelected;
  final int numberSelected;
  final num amount;
  final bool isNightModeEnabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 50.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: isSelected == numberSelected
                ? const Color.fromARGB(255, 0, 111, 4)
                : Colors.black.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(3.r),
          color: isSelected == numberSelected
              ? isNightModeEnabled
                  ? AppColors.kPrimaryColor
                  : AppColors.kPromoteColor
              : isNightModeEnabled
                  ? DarkModeColors.kItemColorDark3
                  : AppColors.kTextFieldColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            FontAwesomeIcons.coins,
            color: Color.fromARGB(255, 233, 211, 13),
            size: 30.sp,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$amount' '${AppStrings.coins.getString(context)}',
                style: TextStyle(fontSize: 15.sp),
              ),
              Text(
                '${(1 / 100 * amount)} EUR',
                style: TextStyle(fontSize: 12.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
