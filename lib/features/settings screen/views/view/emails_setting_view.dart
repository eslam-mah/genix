import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20emails/update_my_emails_cubit.dart';

import '../../../../core/localization/all_app_strings.dart';

class EmailsSettingBody extends StatefulWidget {
  final SettingsModel setting;
  const EmailsSettingBody({
    super.key,
    required this.setting,
  });

  @override
  State<EmailsSettingBody> createState() => _EmailsSettingBodyState();
}

class _EmailsSettingBodyState extends State<EmailsSettingBody> {
  late bool
      isSelected; // Tracks whether to send all emails or only required emails
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize `isSelected` based on the user's current email preference (from the backend)
    isSelected = widget.setting.data?.allowEmails ?? false;
  }

  Future<void> _refreshData() async {
    await context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  Future<void> _savePreferences() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      // Simulate an API call or perform your update logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate delay

      // Call your `UpdateMyEmailsCubit` to update the email settings
      context.read<UpdateMyEmailsCubit>().updateMyEmails(
            allowEmails: isSelected, // Send allow_emails value to the backend
          );

      // Show a success message
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
             CustomHeaderWidget2(text: AppStrings.emailpreferences.getString(context)),
            SizedBox(height: 20.h),
            Text(
              AppStrings.emailnotificationscap.getString(context),
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(AppStrings.selectpushandemailnotificationyouliketorecieve.getString(context)
             ,
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 10.h),

            // Option 1: Send emails about entire activity
            InkWell(
              onTap: () {
                setState(() {
                  isSelected = true; // Set to true when this option is selected
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 9.r,
                    backgroundColor: isSelected == true
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                  ),
                  SizedBox(width: 8.w),
                  Text(AppStrings.sendmeemailsaboutmyentireactivity.getString(context)
                    ,
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),

            // Option 2: Only send required emails
            InkWell(
              onTap: () {
                setState(() {
                  isSelected =
                      false; // Set to false when this option is selected
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 9.r,
                    backgroundColor: isSelected == false
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                  ),
                  SizedBox(width: 8.w),
                  Text(AppStrings.onlysendmerequiredemails.getString(context)
                    ,
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),

            SizedBox(height: 10.h),

            Text(AppStrings.noteYouwillalwaysgetnotificationsforindividualaccountchanges.getString(context)
             ,
              style: TextStyle(fontSize: 10.sp),
            ),
            SizedBox(height: 10.h),

            // Save Preferences Button or Loading Indicator
            Row(
              children: [
                Expanded(
                  child: isLoading
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
                          onTap:
                              _savePreferences, // Call save preferences method
                        ),
                ),
                SizedBox(width: 160.w),
              ],
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
