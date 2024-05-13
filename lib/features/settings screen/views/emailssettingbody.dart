import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';

class EmailsSettingBody extends StatefulWidget {
  const EmailsSettingBody({
    super.key,
    required this.isNightModeEnabled,
  });

  final bool isNightModeEnabled;

  @override
  State<EmailsSettingBody> createState() => _EmailsSettingBodyState();
}

class _EmailsSettingBodyState extends State<EmailsSettingBody> {
  int isSelected = 0;
  bool isLangSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: widget.isNightModeEnabled ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            const CustomHeaderWidget2(text: 'Emails preferences'),
            SizedBox(
              height: 20.h,
            ),
            const Text('EMAIL NOTIFICATIONS',
                style: TextStyle(color: Colors.grey)),
            Text('Select push and email notifications you\'d like to recieve',
                style: TextStyle(color: Colors.black.withOpacity(0.6))),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = 1;
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 9.r,
                    backgroundColor: isSelected == 1
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'Send me emails about my entire activity',
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = 2;
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 9.r,
                    backgroundColor: isSelected == 2
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'Only send me required emails',
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Text('LANGUAGE PREFERENCE',
                style: TextStyle(color: Colors.grey)),
            Text('Select your email language',
                style: TextStyle(color: Colors.black.withOpacity(0.6))),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() async {
                  isLangSelected = !isLangSelected;
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: InkWell(
                            onTap: () {},
                            child: ListTile(
                              title: const Text('English'),
                              trailing: CircleAvatar(
                                  radius: 9.r,
                                  backgroundColor: AppColors.kPrimaryColor2),
                            ),
                          ),
                        );
                      });
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(13.r),
                  border: Border.all(
                    color: isLangSelected
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'English',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp, // Adjust size as needed
                      ),
                    ),
                    const Icon(FontAwesomeIcons.chevronDown),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
                'Note: you will always get notifications you have always turned on for individual account changes.',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 10.sp)),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                      color: AppColors.kPrimaryColor2,
                      buttonText: 'Save preferences',
                      width: 150.w,
                      height: 40.h,
                      borderRadius: 30.r,
                      onTap: () {}),
                ),
                SizedBox(
                  width: 160.w,
                )
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
