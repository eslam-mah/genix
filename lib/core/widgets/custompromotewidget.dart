import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

class CustomPromoteWidget extends StatelessWidget {
  const CustomPromoteWidget({
    super.key,
    required this.isSelected,
    required this.numberSelected,
    required this.coins,
  });

  final int isSelected;
  final int numberSelected;
  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157.w,
      height: 50.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: isSelected == numberSelected
                ? const Color.fromARGB(255, 0, 111, 4)
                : Colors.black.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(3.r),
          color: isSelected == numberSelected
              ? AppColors.kPromoteColor
              : AppColors.kTextFieldColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            FontAwesomeIcons.streetView,
            color: Colors.green,
            size: 30.sp,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$coins Coins',
                style: TextStyle(fontSize: 15.sp),
              ),
              Text(
                '${(1 / 3 * coins).toInt()} Views',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5), fontSize: 12.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
