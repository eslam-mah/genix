import 'package:country_picker/country_picker.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/bigtextfield.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/my%20profile%20screen/widgets/edit_profile_pic.dart';

class ProfileSettingsBody extends StatefulWidget {
  const ProfileSettingsBody({
    super.key,
    required this.isNightModeEnabled,
  });

  final bool isNightModeEnabled;

  @override
  State<ProfileSettingsBody> createState() => _ProfileSettingsBodyState();
}

class _ProfileSettingsBodyState extends State<ProfileSettingsBody> {
  int isSelected = 0;
  bool isContrySelected = false;
  String selectedCountry = 'Your country';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          const CustomHeaderWidget2(text: 'Profile'),
          SizedBox(
            height: 20.h,
          ),
          const Text('EDIT PROFILE', style: TextStyle(color: Colors.grey)),
          Text('People on Genix will get to know you with the info below',
              style: TextStyle(color: Colors.black.withOpacity(0.6))),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 27.r,
                backgroundColor: Colors.purple,
                child: Text('RA',
                    style: TextStyle(color: Colors.white, fontSize: 25.sp)),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  editProfilePicBottomSheet(context);
                },
                child: Text('CHANGE',
                    style: TextStyle(
                        color: AppColors.kPrimaryColor2, fontSize: 12.sp)),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text('DISPLAY NAME', style: TextStyle(color: Colors.grey)),
          SizedBox(
            height: 8.h,
          ),
          CustomTextField2(
              readOnly: false,
              hintText: 'Showing name',
              controller: TextEditingController(),
              isNightModeEnabled: widget.isNightModeEnabled,
              icon: const SizedBox.shrink()),
          SizedBox(
            height: 10.h,
          ),
          const Text('USERNAME', style: TextStyle(color: Colors.grey)),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Text('https://genix.social',
                  style: TextStyle(
                      color: AppColors.kPrimaryColor2, fontSize: 16.sp)),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: CustomTextField2(
                    readOnly: false,
                    hintText: '',
                    controller: TextEditingController(),
                    isNightModeEnabled: widget.isNightModeEnabled,
                    icon: const SizedBox.shrink()),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text('EMAIL ADDRESS', style: TextStyle(color: Colors.grey)),
          SizedBox(
            height: 8.h,
          ),
          CustomTextField2(
              readOnly: false,
              hintText: 'Your email address',
              controller: TextEditingController(),
              isNightModeEnabled: widget.isNightModeEnabled,
              icon: const SizedBox.shrink()),
          SizedBox(
            height: 10.h,
          ),
          const Text('GENDER', style: TextStyle(color: Colors.grey)),
          SizedBox(
            height: 8.h,
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
                  radius: 7.r,
                  backgroundColor: isSelected == 1
                      ? AppColors.kPrimaryColor2
                      : Colors.grey.withOpacity(0.4),
                ),
                SizedBox(
                  width: 8.w,
                ),
                const Text('Male')
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
                  radius: 7.r,
                  backgroundColor: isSelected == 2
                      ? AppColors.kPrimaryColor2
                      : Colors.grey.withOpacity(0.4),
                ),
                SizedBox(
                  width: 8.w,
                ),
                const Text('Female')
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text('Bio', style: TextStyle(color: Colors.grey)),
          SizedBox(
            width: 8.w,
          ),
          const BigTextField(
              hintText: 'Tell us more about you', color: Colors.transparent),
          SizedBox(
            height: 10.h,
          ),
          const Text('CITY', style: TextStyle(color: Colors.grey)),
          SizedBox(
            width: 8.w,
          ),
          CustomTextField2(
              readOnly: false,
              hintText: 'Your city',
              controller: TextEditingController(),
              isNightModeEnabled: widget.isNightModeEnabled,
              icon: const SizedBox.shrink()),
          SizedBox(
            height: 10.h,
          ),
          const Text('COUNTRY', style: TextStyle(color: Colors.grey)),
          SizedBox(
            width: 8.w,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  isContrySelected = !isContrySelected;
                });
                showCountryPicker(
                  context: context,
                  onSelect: (Country country) {
                    setState(() {
                      selectedCountry = country.displayNameNoCountryCode;
                    });
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(13.r),
                  border: Border.all(
                    color: isContrySelected
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCountry,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp, // Adjust size as needed
                      ),
                    ),
                    const Icon(FontAwesomeIcons.chevronDown),
                  ],
                ),
              )),
          SizedBox(
            height: 10.h,
          ),
          const Text('PAYPAL E-MAIL ADDRESS',
              style: TextStyle(color: Colors.grey)),
          SizedBox(
            width: 8.w,
          ),
          CustomTextField2(
              readOnly: false,
              hintText: 'Enter your PayPal e-mail address',
              controller: TextEditingController(),
              isNightModeEnabled: widget.isNightModeEnabled,
              icon: const SizedBox.shrink()),
          SizedBox(
            height: 10.h,
          ),
          const Text('SOCIAL PROFILES', style: TextStyle(color: Colors.grey)),
          SizedBox(
            width: 8.w,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.facebook,
                size: 27.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: CustomTextField2(
                      readOnly: false,
                      hintText: 'Facebook profile link',
                      controller: TextEditingController(),
                      isNightModeEnabled: widget.isNightModeEnabled,
                      icon: const SizedBox.shrink()))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.tiktok,
                size: 27.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: CustomTextField2(
                      readOnly: false,
                      hintText: 'Tiktok profile link',
                      controller: TextEditingController(),
                      isNightModeEnabled: widget.isNightModeEnabled,
                      icon: const SizedBox.shrink()))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.instagram,
                size: 27.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: CustomTextField2(
                      readOnly: false,
                      hintText: 'Instagram profile link',
                      controller: TextEditingController(),
                      isNightModeEnabled: widget.isNightModeEnabled,
                      icon: const SizedBox.shrink()))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.xTwitter,
                size: 27.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: CustomTextField2(
                      readOnly: false,
                      hintText: 'Twitter profile link',
                      controller: TextEditingController(),
                      isNightModeEnabled: widget.isNightModeEnabled,
                      icon: const SizedBox.shrink()))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.pinterest,
                size: 27.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: CustomTextField2(
                      readOnly: false,
                      hintText: 'Pinterest profile link',
                      controller: TextEditingController(),
                      isNightModeEnabled: widget.isNightModeEnabled,
                      icon: const SizedBox.shrink()))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.steam,
                size: 27.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: CustomTextField2(
                      readOnly: false,
                      hintText: 'Steam profile link',
                      controller: TextEditingController(),
                      isNightModeEnabled: widget.isNightModeEnabled,
                      icon: const SizedBox.shrink()))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.linkedin,
                size: 27.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: CustomTextField2(
                      readOnly: false,
                      hintText: 'Linkidin profile link',
                      controller: TextEditingController(),
                      isNightModeEnabled: widget.isNightModeEnabled,
                      icon: const SizedBox.shrink()))
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
              onTap: () {}),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
