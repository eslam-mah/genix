import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import '../../../../core/localization/all_app_strings.dart';

class CustomBillingWidget2 extends StatefulWidget {
  CustomBillingWidget2({
    super.key,
    required this.isSelected,
    required this.numberSelected,
    required this.isNightModeEnabled,
    required this.onAmountChanged,
  });

  int isSelected;
  final int numberSelected;
  final bool isNightModeEnabled;
  final Function(int) onAmountChanged; // Callback for passing amount to parent

  @override
  State<CustomBillingWidget2> createState() => _CustomBillingWidget2State();
}

class _CustomBillingWidget2State extends State<CustomBillingWidget2> {
  TextEditingController textEditingController = TextEditingController();
  int coins = 0;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(coinsToViews);
    coinsToViews();
  }

  @override
  void dispose() {
    textEditingController.removeListener(coinsToViews);
    textEditingController.dispose();
    super.dispose();
  }

  void coinsToViews() {
    if (textEditingController.text.isNotEmpty) {
      int inputAmount = int.tryParse(textEditingController.text) ?? 0;
      setState(() {
        coins = inputAmount ~/ 100; // Integer division to get whole number
      });
      widget.onAmountChanged(coins); // Pass the converted amount to parent
    } else {
      setState(() {
        coins = 0;
      });
      widget.onAmountChanged(coins); // Reset to 0 if empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isSelected == widget.numberSelected
              ? const Color.fromARGB(255, 0, 111, 4)
              : Colors.black.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(3.r),
        color: widget.isSelected == widget.numberSelected
            ? widget.isNightModeEnabled
                ? AppColors.kPrimaryColor
                : AppColors.kPromoteColor
            : widget.isNightModeEnabled
                ? DarkModeColors.kItemColorDark3
                : AppColors.kTextFieldColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            FontAwesomeIcons.coins,
            color: const Color.fromARGB(255, 233, 211, 13),
            size: 30.sp,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: SizedBox(
                  height: 22.h,
                  width: 97.w,
                  child: TextField(
                    controller: textEditingController,
                    onTap: () {
                      setState(() {
                        widget.isSelected =
                            widget.isSelected == widget.numberSelected
                                ? 0
                                : widget.numberSelected;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5.h),
                      hintText: AppStrings.customamount.getString(context),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  '$coins EUR', // Display the integer result
                  style: TextStyle(fontSize: 12.sp),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
