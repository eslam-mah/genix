import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

// ignore: must_be_immutable
class CustomPromoteWidget2 extends StatefulWidget {
  CustomPromoteWidget2({
    super.key,
    required this.isSelected,
    required this.numberSelected,
    required this.coins,
  });

  int isSelected;
  final int numberSelected;
  final int coins;

  @override
  State<CustomPromoteWidget2> createState() => _CustomPromoteWidget2State();
}

class _CustomPromoteWidget2State extends State<CustomPromoteWidget2> {
  TextEditingController textEditingController = TextEditingController();
  int views = 0;

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
      int coins = int.tryParse(textEditingController.text) ?? 0;
      setState(() {
        views = (coins / 3).floor();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157.w,
      height: 50.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: widget.isSelected == widget.numberSelected
                ? const Color.fromARGB(255, 0, 111, 4)
                : Colors.black.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(3.r),
          color: widget.isSelected == widget.numberSelected
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
                    decoration: const InputDecoration(
                      hintText: 'Custom amount',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0), // Reduce padding
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
                  '$views Views',
                  style: TextStyle(fontSize: 12.sp),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
