import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/bigtextfield.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20account/update_my_account_cubit.dart';
import 'package:genix/features/settings%20screen/views/widgets/custom_profile_image.dart';
import 'package:genix/features/splash%20screen/splashscreen.dart';
import 'package:genix/main.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/localization/all_app_strings.dart';

class ProfileSettingsBody extends StatefulWidget {
  final SettingsModel setting;

  const ProfileSettingsBody({
    super.key,
    required this.setting,
  });

  @override
  State<ProfileSettingsBody> createState() => _ProfileSettingsBodyState();
}

class _ProfileSettingsBodyState extends State<ProfileSettingsBody> {
  late TextEditingController showNameController;
  late TextEditingController userNameController;
  late TextEditingController emailAddressController;
  late TextEditingController bioController;
  late TextEditingController cityController;
  late TextEditingController payPalEmailController;
  late TextEditingController facebookController;
  late TextEditingController instagramController;
  late TextEditingController xController;
  late TextEditingController tiktokController;
  late TextEditingController pinterestController;
  late TextEditingController steamController;
  late TextEditingController linkedinController;

  late String selectedCountry;
  bool isCountrySelected = false;
  late String gender;
  bool isLoading = false; // To control loading state

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
    _initSharedPreferences();
    showNameController =
        TextEditingController(text: widget.setting.data?.showname);
    userNameController =
        TextEditingController(text: widget.setting.data?.username);
    emailAddressController =
        TextEditingController(text: widget.setting.data?.email);
    bioController = TextEditingController(text: widget.setting.data?.bio);
    cityController = TextEditingController(text: widget.setting.data?.city);
    payPalEmailController =
        TextEditingController(text: widget.setting.data?.paypalEmail);
    facebookController =
        TextEditingController(text: widget.setting.data?.socialFacebook);
    tiktokController =
        TextEditingController(text: widget.setting.data?.socialTiktok);
    instagramController =
        TextEditingController(text: widget.setting.data?.socialInstagram);
    xController =
        TextEditingController(text: widget.setting.data?.socialTwitter);
    pinterestController =
        TextEditingController(text: widget.setting.data?.socialPinterest);
    steamController =
        TextEditingController(text: widget.setting.data?.socialSteam);
    linkedinController =
        TextEditingController(text: widget.setting.data?.socialLinkedin);
    gender = widget.setting.data?.gender ?? 'male';
    selectedCountry = widget.setting.data?.country ?? '';
  }

  final FlutterLocalization localization = FlutterLocalization.instance;
  late SharedPreferences prefs;

  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'es', 'name': 'Español'},
    {'code': 'de', 'name': 'Deutsch'},
    {'code': 'fr', 'name': 'Français'},
    {'code': 'it', 'name': 'Italiano'},
    {'code': 'hu', 'name': 'Magyar'},
    {'code': 'nl', 'name': 'Nederlands'},
    {'code': 'pl', 'name': 'Polski'},
    {'code': 'pt', 'name': 'Português'},
    {'code': 'ro', 'name': 'Română'},
    {'code': 'sl', 'name': 'Slovenščina'},
    {'code': 'tr', 'name': 'Türkçe'},
    {'code': 'cs', 'name': 'Čeština'},
    {'code': 'uk', 'name': 'Українська'},
  ];
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      // Add other routes here if needed
    ],
  );

  String selectedLanguageCode = 'en';
  bool isLanguageDropdownOpen = false;
  void _onLanguageSelected(String newValue) async {
    // Show Cupertino loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CupertinoActivityIndicator(color: AppColors.kPrimaryColor,animating: true,),
            SizedBox(height: 12.h),
            Text(AppStrings.changinglanguage.getString(context)),
          ],
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 3));
    await _saveLanguagePreference(newValue);
    FlutterLocalization.instance.translate(newValue);
    Navigator.pop(context);
    if (context.mounted) {
      Navigator.pop(context);
      Phoenix.rebirth(context); // This one line will restart the app
    }
    // Navigator.push(context, CupertinoPageRoute(builder: (_)
    // => const SplashScreen()));
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguageCode = prefs.getString('language_code') ?? 'en';
    });
  }

  _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String savedLanguageCode = prefs.getString('language_code') ?? 'en';
    setState(() {
      selectedLanguageCode = savedLanguageCode;
    });
    // Update localization based on saved language
    FlutterLocalization.instance.translate(savedLanguageCode);
  }

  // Save selected language code to SharedPreferences
  _saveLanguagePreference(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language_code', languageCode);
  }

  Future<void> _refreshData() async {
    // Call the cubit method to refresh account details
    await context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  Future<void> _savePreferences() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      // Simulate an API call or perform your update logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate delay

      // After successful request:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppStrings.settingssaved.getString(context),
            style: TextStyle(fontSize: 13.sp),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle errors here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppStrings.failedtosavesettigns.getString(context),
            style: TextStyle(fontSize: 13.sp),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator after completion
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: AppColors.kPrimaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(
              height: 20.h,
            ),
            CustomHeaderWidget2(text: AppStrings.profilecap.getString(context)),
            SizedBox(
              height: 20.h,
            ),
            Text(AppStrings.editprofilecap.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            Text(
                AppStrings.peopleongenixwillgettoknowbybelowinfo
                    .getString(context),
                style: TextStyle(
                  fontSize: 12.sp,
                )),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                CustomProfileImage(
                  image: widget.setting.data?.profileImg ?? "",
                  width: 80.w,
                  height: 80.w,
                  showname: widget.setting.data?.showname ?? "",
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: () {
                    // ignore: unused_element
                    editProfilePicBottomSheet(
                        context, Function(String) onImageSelected) {}
                  },
                  child: Text(AppStrings.changecap.getString(context),
                      style: TextStyle(
                          color: AppColors.kPrimaryColor2, fontSize: 12.sp)),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.displaynamecap.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              height: 8.h,
            ),
            CustomTextField2(
                readOnly: false,
                hintText: AppStrings.showingname.getString(context),
                controller: showNameController,
                icon: const SizedBox.shrink()),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.usernamecap.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Text('https://genix.social/@',
                    style: TextStyle(
                        color: AppColors.kPrimaryColor2, fontSize: 16.sp)),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: CustomTextField2(
                      readOnly: false,
                      hintText: '',
                      controller: userNameController,
                      icon: const SizedBox.shrink()),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.emailaddressecap.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              height: 8.h,
            ),
            CustomTextField2(
                readOnly: false,
                hintText: AppStrings.youremailaddress.getString(context),
                controller: emailAddressController,
                icon: const SizedBox.shrink()),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.gendercap.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              height: 8.h,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  gender = 'male';
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 7.r,
                    backgroundColor: gender == 'male'
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(AppStrings.male.getString(context))
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  gender = 'female';
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 7.r,
                    backgroundColor: gender == 'female'
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(AppStrings.female.getString(context))
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.bio.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              width: 8.w,
            ),
            BigTextField(
              hintText: AppStrings.tellusmoreaboutyou.getString(context),
              controller: bioController,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.citycap.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              width: 8.w,
            ),
            CustomTextField2(
                readOnly: false,
                hintText: AppStrings.yourcity.getString(context),
                controller: cityController,
                icon: const SizedBox.shrink()),
            SizedBox(
              height: 10.h,
            ),
            /////languages

            Text(AppStrings.languagecap.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              width: 8.w,
            ),
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(13.r),
                border: Border.all(
                  color: isLanguageDropdownOpen
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: DropdownButton<String>(
                value: selectedLanguageCode,
                isExpanded: true,
                underline: Container(),
                hint: Text(AppStrings.selectlanguage.getString(context)),
                items: languages.map((language) {
                  return DropdownMenuItem<String>(
                    value: language['code'],
                    child: Text(language['name']!),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedLanguageCode = newValue;
                    });
                    _onLanguageSelected(newValue);
                  }
                },
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
            //////languages
            Text(AppStrings.countrycap.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              width: 8.w,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    isCountrySelected = !isCountrySelected;
                  });
                  showCountryPicker(
                    context: context,
                    onSelect: (Country country) {
                      setState(() {
                        selectedCountry = country.countryCode;
                      });
                    },
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(13.r),
                    border: Border.all(
                      color: isCountrySelected
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
                          fontSize: 16.sp, // Adjust size as needed
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronDown,
                        size: 18.r,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.paypalemailaddress.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
            SizedBox(
              width: 8.w,
            ),
            CustomTextField2(
                readOnly: false,
                hintText:
                    AppStrings.enteryourpaypalemailaddress.getString(context),
                controller: payPalEmailController,
                icon: const SizedBox.shrink()),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.socialprofilelinks.getString(context),
                style: TextStyle(
                  fontSize: 14.sp,
                )),
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
                        hintText:
                            AppStrings.facebookprofilelink.getString(context),
                        controller: facebookController,
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
                        hintText:
                            AppStrings.tiktokprofilelink.getString(context),
                        controller: tiktokController,
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
                        hintText:
                            AppStrings.instagramprofilelink.getString(context),
                        controller: instagramController,
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
                        hintText: AppStrings.xprofilelink.getString(context),
                        controller: xController,
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
                        hintText:
                            AppStrings.pinterestprofilelink.getString(context),
                        controller: pinterestController,
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
                        hintText:
                            AppStrings.steamprofilelink.getString(context),
                        controller: steamController,
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
                        hintText:
                            AppStrings.linkedInprofilelink.getString(context),
                        controller: linkedinController,
                        icon: const SizedBox.shrink()))
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ), // Loading indicator
                  )
                : CustomButton(
                    color: AppColors.kPrimaryColor2,
                    buttonText: AppStrings.savepreferences.getString(context),
                    width: 150.w,
                    height: 40.h,
                    borderRadius: 30.r,
                    onTap: () {
                      _savePreferences();
                      context
                          .read<UpdateMyAccountCubit>()
                          .updateMyAccountDetails(
                              showName: showNameController.text.trim(),
                              userName: userNameController.text.trim(),
                              email: emailAddressController.text.trim(),
                              bio: bioController.text.trim(),
                              payPalEmail: payPalEmailController.text.trim(),
                              facebook: facebookController.text.trim(),
                              x: xController.text.trim(),
                              instagram: instagramController.text.trim(),
                              tiktok: tiktokController.text.trim(),
                              pinterest: pinterestController.text.trim(),
                              steam: steamController.text.trim(),
                              linkedIn: linkedinController.text.trim(),
                              city: cityController.text.trim(),
                              country: selectedCountry,
                              gender: gender,
                              profileImg: File(''));
                    }),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
