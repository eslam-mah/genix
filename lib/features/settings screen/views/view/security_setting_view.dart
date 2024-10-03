import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/customtextfield2.dart';

class SecuritySettingsBody extends StatefulWidget {
  const SecuritySettingsBody({
    super.key,
    required this.isNightModeEnabled,
  });

  final bool isNightModeEnabled;

  @override
  State<SecuritySettingsBody> createState() => _SecuritySettingsBodyState();
}

class _SecuritySettingsBodyState extends State<SecuritySettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          const CustomHeaderWidget2(text: 'Security'),
          SizedBox(
            height: 20.h,
          ),
          Text('ACCOUNT PASSWORD',
              style: TextStyle(
                fontSize: 14.sp,
              )),
          Text('Change your password and alter other security options',
              style: TextStyle(
                fontSize: 12.sp,
              )),
          SizedBox(
            height: 20.h,
          ),
          Text('CURRENT PASSWORD',
              style: TextStyle(
                fontSize: 14.sp,
              )),
          SizedBox(
            height: 8.h,
          ),
          CustomTextField2(
              readOnly: false,
              hintText: 'Current password',
              controller: TextEditingController(),
              isNightModeEnabled: widget.isNightModeEnabled,
              icon: const SizedBox.shrink()),
          SizedBox(
            height: 10.h,
          ),
          Text('MIN 8 CHARACTERS',
              style: TextStyle(
                fontSize: 14.sp,
              )),
          SizedBox(
            height: 8.h,
          ),
          CustomTextField2(
              readOnly: false,
              hintText: 'New password',
              controller: TextEditingController(),
              isNightModeEnabled: widget.isNightModeEnabled,
              icon: const SizedBox.shrink()),
          SizedBox(
            height: 10.h,
          ),
          Text('REPEAT NEW PASSWORD',
              style: TextStyle(
                fontSize: 14.sp,
              )),
          SizedBox(
            height: 8.h,
          ),
          CustomTextField2(
              readOnly: false,
              hintText: 'Confirm password',
              controller: TextEditingController(),
              isNightModeEnabled: widget.isNightModeEnabled,
              icon: const SizedBox.shrink()),
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
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TWO FACTOR AUTHENTICATION',
                      style: TextStyle(
                        fontSize: 14.sp,
                      )),
                  Row(
                    children: [
                      Text('Enable',
                          style: TextStyle(
                            fontSize: 12.sp,
                          )),
                      Text(
                        ' Two factor authentication',
                        style: TextStyle(
                          color: AppColors.kPrimaryColor2,
                          fontSize: 12.sp,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 23.w,
              ),
              Expanded(
                child: CustomButton(
                    color: AppColors.kPrimaryColor2,
                    buttonText: 'ENABLE',
                    width: 150.w,
                    height: 40.h,
                    borderRadius: 30.r,
                    onTap: () {}),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ACCOUNT CLOSURE',
                      style: TextStyle(
                        fontSize: 14.sp,
                      )),
                  Text('Delete your account and data',
                      style: TextStyle(
                        fontSize: 12.sp,
                      )),
                ],
              ),
              SizedBox(
                width: 45.w,
              ),
              Expanded(
                child: CustomButton(
                    color: Colors.red,
                    buttonText: 'DELETE',
                    width: 150.w,
                    height: 40.h,
                    borderRadius: 30.r,
                    onTap: () {}),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
