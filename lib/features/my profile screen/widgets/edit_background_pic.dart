import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';

Future<dynamic> editBackgroundPicBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.kPostColor,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 40.h),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.image,
                    color: Colors.green,
                    size: 50.r,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'First of all, select an image',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                      color: AppColors.kPrimaryColor2,
                      buttonText: 'Browse on device',
                      width: 160.w,
                      height: 40.h,
                      borderRadius: 7.r,
                      onTap: () {})
                ],
              ),
            ),
          ),
        );
      });
}
