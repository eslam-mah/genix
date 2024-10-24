import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20emails/update_my_emails_cubit.dart';

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
            'Settings Saved',
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
            'Failed to save settings',
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
            const CustomHeaderWidget2(text: 'Emails preferences'),
            SizedBox(height: 20.h),
            Text(
              'EMAIL NOTIFICATIONS',
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              'Select push and email notifications you\'d like to receive',
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
                  Text(
                    'Send me emails about my entire activity',
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
                  Text(
                    'Only send me required emails',
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              'Note: You will always get notifications for individual account changes.',
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
                          buttonText: 'Save preferences',
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
