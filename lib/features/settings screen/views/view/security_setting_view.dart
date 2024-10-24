import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/view%20model/delete%20my%20account/delete_my_account_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20account/update_my_account_cubit.dart';
import 'package:go_router/go_router.dart';

class SecuritySettingsBody extends StatefulWidget {
  final SettingsModel setting;

  const SecuritySettingsBody({
    super.key,
    required this.setting,
  });

  @override
  State<SecuritySettingsBody> createState() => _SecuritySettingsBodyState();
}

class _SecuritySettingsBodyState extends State<SecuritySettingsBody> {
  bool isLoading = false;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  late TextEditingController showNameController;
  late TextEditingController userNameController;
  late TextEditingController emailAddressController;
  late TextEditingController bioController;
  late TextEditingController cityController;
  late String selectedCountry;
  late String gender;
  Future<void> _refreshData() async {
    // Call the cubit method to refresh account details
    await context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  @override
  void initState() {
    super.initState();

    showNameController =
        TextEditingController(text: widget.setting.data?.showname);
    userNameController =
        TextEditingController(text: widget.setting.data?.username);
    emailAddressController =
        TextEditingController(text: widget.setting.data?.email);
    bioController = TextEditingController(text: widget.setting.data?.bio);
    cityController = TextEditingController(text: widget.setting.data?.city);
    gender = widget.setting.data?.gender ?? 'male';
    selectedCountry = widget.setting.data?.country ?? '';
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
                controller: currentPasswordController,
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
                controller: newPasswordController,
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
                icon: const SizedBox.shrink()),
            SizedBox(
              height: 10.h,
            ),
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
                          onTap: () {
                            _savePreferences();
                            context
                                .read<UpdateMyAccountCubit>()
                                .updateMyAccountDetails(
                                  showName: showNameController.text.trim(),
                                  userName: userNameController.text.trim(),
                                  email: emailAddressController.text.trim(),
                                  bio: bioController.text.trim(),
                                  city: cityController.text.trim(),
                                  country: selectedCountry,
                                  gender: gender,
                                  profileImg: File(''),
                                  currentPassword:
                                      currentPasswordController.text.trim(),
                                  newPassword:
                                      newPasswordController.text.trim(),
                                );
                          }),
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
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              // Wrap the dialog in a BlocProvider to ensure access to DeleteMyAccountCubit
                              return BlocProvider(
                                create: (context) =>
                                    DeleteMyAccountCubit(), // Provide the cubit here
                                child: const _DeleteMyAccountDialog(),
                              );
                            });
                      }),
                ),
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

class _DeleteMyAccountDialog extends StatelessWidget {
  const _DeleteMyAccountDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocBuilder<DeleteMyAccountCubit, DeleteMyAccountState>(
        builder: (context, state) {
          if (state is DeleteMyAccountLoading) {
            return SizedBox(
              height: 100.h,
              width: 300.w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          } else {
            return SizedBox(
              height: 100.h,
              width: 300.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Are you sure you want to delete your account?',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: 'Yes',
                          height: 30.h,
                          borderRadius: 30.r,
                          width: 80.w,
                          onTap: () async {
                            await context
                                .read<DeleteMyAccountCubit>()
                                .deleteAccount();

                            // ignore: use_build_context_synchronously
                            GoRouter.of(context).go(LoginScreen.route,
                                extra: const LogInScreenArgs());
                          }),
                      CustomButton(
                          color: Colors.red,
                          buttonText: 'no',
                          height: 30.h,
                          borderRadius: 30.r,
                          width: 80.w,
                          onTap: () {
                            GoRouter.of(context).pop();
                          })
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
