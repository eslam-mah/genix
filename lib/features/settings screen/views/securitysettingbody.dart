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
          const Text('ACCOUNT PASSWORD', style: TextStyle(color: Colors.grey)),
          Text('Change your password and alter other security options',
              style: TextStyle(color: Colors.black.withOpacity(0.6))),
          SizedBox(
            height: 20.h,
          ),
          const Text('CURRENT PASSWORD', style: TextStyle(color: Colors.grey)),
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
          const Text('MIN 8 CHARACTERS', style: TextStyle(color: Colors.grey)),
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
          const Text('REPEAT NEW PASSWORD',
              style: TextStyle(color: Colors.grey)),
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
                  const Text('TWO FACTOR AUTHENTICATION',
                      style: TextStyle(color: Colors.grey)),
                  Row(
                    children: [
                      Text('Enable',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6))),
                      Text(
                        ' Two factor authentication',
                        style: TextStyle(color: AppColors.kPrimaryColor2),
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
                  const Text('ACCOUNT CLOSURE',
                      style: TextStyle(color: Colors.grey)),
                  Row(
                    children: [
                      Text('Delete your account and data',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6))),
                    ],
                  ),
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
