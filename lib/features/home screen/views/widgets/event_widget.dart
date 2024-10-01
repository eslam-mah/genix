import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/customtextwidget.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.eventText,
    required this.isNightMode,
  });
  final IconData icon;
  final String text;
  final String eventText;
  final bool isNightMode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.w,
      height: 70.h,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(6.r)),
              child: Icon(
                icon,
                size: 30.r,
              ),
            ),
            SizedBox(
              width: 90.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                      textSize: 13.sp,
                      isNightMode: isNightMode,
                      fontFamily: '',
                      fontWeight: FontWeight.bold,
                      text: text),
                  CustomTextWidget(
                      textSize: 16.sp,
                      isNightMode: isNightMode,
                      fontFamily: '',
                      fontWeight: FontWeight.normal,
                      text: eventText),
                ],
              ),
            )
          ]),
    );
  }
}
