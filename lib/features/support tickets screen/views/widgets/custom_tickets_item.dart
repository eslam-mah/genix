import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/widgets/custom_small_user_profile_image.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';

class CustomTicketsItem extends StatelessWidget {
  const CustomTicketsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 6.h),
      child: Container(
          color: Colors.grey.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomUserProfileImage(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.lock,
                        size: 12.r,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomTextWidget(
                          textSize: 12.sp,
                          fontFamily: '',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          text: 'Test')
                    ],
                  ),
                  CustomTextWidget(
                      textSize: 12.sp,
                      fontFamily: '',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      text: 'Created on october 11')
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                      textSize: 12.sp,
                      fontFamily: '',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      text: 'Last reply by'),
                  Row(
                    children: [
                      CustomSmallUserProfileImage(),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomTextWidget(
                          textSize: 12.sp,
                          fontFamily: '',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          text: 'data'),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
