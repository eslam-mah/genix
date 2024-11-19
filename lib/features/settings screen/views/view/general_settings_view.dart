import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/localization/all_app_strings.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/settings%20screen/data/models/billing_form.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20general%20settings/update_general_settings_cubit.dart';

class GeneralSettingsBody extends StatefulWidget {
  final SettingsModel setting;

  const GeneralSettingsBody({
    super.key,
    required this.setting,
  });

  @override
  State<GeneralSettingsBody> createState() => _GeneralSettingsBodyState();
}

class _GeneralSettingsBodyState extends State<GeneralSettingsBody> {
  late bool followMeEnabled;
  late bool profileHidden;
  late bool notificationsSent;
  late bool hideGender;
  late bool hideAge;
  late bool hideLocation;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize switches based on SettingsModel values
    followMeEnabled = widget.setting.data?.allowFollowers ?? false;
    profileHidden = widget.setting.data?.allowSearchEngines ?? false;
    notificationsSent = widget.setting.data?.allowNotifications ?? false;
    hideGender = widget.setting.data?.hideGender ?? false;
    hideAge = widget.setting.data?.hideAge ?? false;
    hideLocation = widget.setting.data?.hideLocation ?? false;
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
          content: Text(AppStrings.settingssaved.getString(context),
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
      child: SingleChildScrollView(
        physics:
            const AlwaysScrollableScrollPhysics(), // Required for RefreshIndicator
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
               CustomHeaderWidget2(text: AppStrings.general.getString(context)),
              SizedBox(height: 10.h),

              // Follow Me Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.enablefollowmecap.getString(context),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(AppStrings.enablethisifyouwantpeopletofollowyou.getString(context),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Switch(
                    value: followMeEnabled,
                    activeTrackColor: AppColors.kPrimaryColor2,
                    onChanged: (value) {
                      setState(() {
                        followMeEnabled = value;
                        // widget.setting.data?.allowFollowers = value;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // Notifications Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.sendmenotificationscap.getString(context),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        AppStrings.sendmenotificationaboutmyfriendlike.getString(context),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Text(
                        AppStrings.shareormessageme.getString(context),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Switch(
                    value: notificationsSent,
                    activeTrackColor: AppColors.kPrimaryColor2,
                    onChanged: (value) {
                      setState(() {
                        notificationsSent = value;
                        // widget.setting.data?.allowNotifications = value;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // Search Privacy Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.searchprivacycap.getString(context),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        AppStrings.hideyourprofilefromsearchengine.getString(context),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Switch(
                    value: profileHidden,
                    activeTrackColor: AppColors.kPrimaryColor2,
                    onChanged: (value) {
                      setState(() {
                        profileHidden = value;
                        // widget.setting.data?.allowSearchEngines = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.hidegendercap.getString(context),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Switch(
                    value: hideGender,
                    activeTrackColor: AppColors.kPrimaryColor2,
                    onChanged: (value) {
                      setState(() {
                        hideGender = value;
                        // widget.setting.data?.hideGender = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.hideagecap.getString(context),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Switch(
                    value: hideAge,
                    activeTrackColor: AppColors.kPrimaryColor2,
                    onChanged: (value) {
                      setState(() {
                        hideAge = value;
                        // widget.setting.data?.hideAge = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.hidelocationcap.getString(context),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Switch(
                    value: hideLocation,
                    activeTrackColor: AppColors.kPrimaryColor2,
                    onChanged: (value) {
                      setState(() {
                        hideLocation = value;
                        // widget.setting.data?.hideLocation = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),

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
                            .read<UpdateGeneralSettingsCubit>()
                            .updateGeneralSettings(
                                data: GeneralSettingsForm(
                                    allowFollowers: followMeEnabled,
                                    allowNotifications: notificationsSent,
                                    allowSearchEngines: profileHidden,
                                    hideGender: hideGender,
                                    hideAge: hideAge,
                                    locale: 'english',
                                    hideLocation: hideLocation));
                      },
                    ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
