import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';

class GeneralSettingsBody extends StatefulWidget {
  const GeneralSettingsBody({
    super.key,
    required this.isNightModeEnabled,
  });
  final bool isNightModeEnabled;
  @override
  State<GeneralSettingsBody> createState() => _GeneralSettingsBodyState();
}

class _GeneralSettingsBodyState extends State<GeneralSettingsBody> {
  bool followMeEnabled = true;
  bool profileHiden = false;
  bool notificationsSent = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          const CustomHeaderWidget2(text: 'General'),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ENABLE FOLLOW ME',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('Enable this if you want people to follow you.',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)))
                ],
              ),
              Switch(
                  value: followMeEnabled,
                  activeTrackColor: AppColors.kPrimaryColor2,
                  onChanged: (value) {
                    setState(() {
                      followMeEnabled = !followMeEnabled;
                    });
                  })
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SEND ME NOTIFICATIONS',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('Send me notifications about my friends, like,',
                      style: TextStyle(color: Colors.black.withOpacity(0.6))),
                  Text('share or message me.',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)))
                ],
              ),
              Switch(
                  value: profileHiden,
                  activeTrackColor: AppColors.kPrimaryColor2,
                  onChanged: (value) {
                    setState(() {
                      profileHiden = !profileHiden;
                    });
                  })
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SEARCH PRIVACY',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('Hide your profile from search engine.',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)))
                ],
              ),
              Switch(
                  value: notificationsSent,
                  activeTrackColor: AppColors.kPrimaryColor2,
                  onChanged: (value) {
                    setState(() {
                      notificationsSent = !notificationsSent;
                    });
                  })
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomButton(
              color: AppColors.kPrimaryColor2,
              buttonText: 'Save preferences',
              width: 150.w,
              height: 40.h,
              borderRadius: 30.r,
              onTap: () {})
        ],
      ),
    );
  }
}
