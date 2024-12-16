import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:genix/core/utils/api_end_points.dart';
import 'package:genix/features/settings%20screen/views/view/two_fa_dialoguye.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/view%20model/api_service.dart';
import 'package:genix/features/settings%20screen/view%20model/delete%20my%20account/delete_my_account_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20account/update_my_account_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/localization/all_app_strings.dart';

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
  late bool twoFAenabled;

  Future<void> _refreshData() async {
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
    twoFAenabled = widget.setting.data?.tfaEnabled ?? false;
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    showNameController.dispose();
    userNameController.dispose();
    emailAddressController.dispose();
    bioController.dispose();
    cityController.dispose();
    super.dispose();
  }

  Future<void> _savePreferences() async {
    setState(() {
      isLoading = true;
    });

    try {
      await context.read<UpdateMyAccountCubit>().updateMyAccountDetails(
            showName: showNameController.text.trim(),
            userName: userNameController.text.trim(),
            email: emailAddressController.text.trim(),
            bio: bioController.text.trim(),
            city: cityController.text.trim(),
            country: selectedCountry,
            gender: gender,
            profileImg: File(''),
            currentPassword: currentPasswordController.text.trim(),
            newPassword: newPasswordController.text.trim(),
          );

      if (mounted) {
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
      }
    } catch (e) {
      if (mounted) {
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
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showConfirmPasswordDialog(BuildContext context, String token) {
    final TextEditingController passwordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              Text(
                'Please enter password before starting',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        const BorderSide(color: AppColors.kPrimaryColor2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        const BorderSide(color: AppColors.kPrimaryColor),
                  ),
                ),
              ),
              if (isLoading)
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: const CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (twoFAenabled) {
                        await disableTwoFactorAuth(context, token);
                        Navigator.pop(dialogContext);
                      } else {
                        setDialogState(() => isLoading = true);
                        try {
                          final success = await confirmPassword(
                            passwordController.text.toString(),
                            dialogContext,
                            token,
                          );

                          if (success && mounted) {
                            Navigator.pop(dialogContext);
                          }
                        } finally {
                          if (mounted) {
                            setDialogState(() => isLoading = false);
                          }
                        }
                      }
                    },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: AppColors.kPrimaryColor2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> confirmPassword(
    String password,
    BuildContext context,
    String token,
  ) async {
    const url = ApiEndPoints.confirmPasswordfor2Fa;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'password': password}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await enableTwoFactorAuth(context, token);
        print('success');
        if (context.mounted) {}
        return true;
      } else {
        if (context.mounted) {
          print('failed ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to confirm password: ${response.body}',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    }
  }

  Future<void> enableTwoFactorAuth(BuildContext context, String token) async {
    final dio = Dio();
    const url = ApiEndPoints.enableTwoFactorAuthentication;

    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await dio.post(url);

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (context.mounted) {
          final result = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => TwoFactorSetupDialog(token: token),
          );

          if (result == true) {
            // 2FA setup completed successfully
          }
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
            SizedBox(height: 20.h),
            CustomHeaderWidget2(text: AppStrings.security.getString(context)),
            SizedBox(height: 20.h),
            Text(
              AppStrings.accountpasswordcap.getString(context),
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              AppStrings.changeyourpasswordandalterothersecurityoptions
                  .getString(context),
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 20.h),
            Text(
              AppStrings.currentpasswordcap.getString(context),
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),
            CustomTextField2(
              readOnly: false,
              hintText: AppStrings.currentpassword.getString(context),
              controller: currentPasswordController,
              icon: const SizedBox.shrink(),
            ),
            SizedBox(height: 10.h),
            Text(
              AppStrings.mineightcharacters.getString(context),
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),
            CustomTextField2(
              readOnly: false,
              hintText: AppStrings.newpassword.getString(context),
              controller: newPasswordController,
              icon: const SizedBox.shrink(),
            ),
            SizedBox(height: 10.h),
            Text(
              AppStrings.repeatnewpassword.getString(context),
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),
            CustomTextField2(
              readOnly: false,
              hintText: AppStrings.confirmpassword.getString(context),
              controller: TextEditingController(),
              icon: const SizedBox.shrink(),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimaryColor,
                          ),
                        )
                      : CustomButton(
                          color: AppColors.kPrimaryColor2,
                          buttonText:
                              AppStrings.savepreferences.getString(context),
                          width: 150.w,
                          height: 40.h,
                          borderRadius: 30.r,
                          onTap: _savePreferences,
                        ),
                ),
                SizedBox(width: 160.w),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.twofactorauthenticationcap.getString(context),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Row(
                      children: [
                        Text(
                          twoFAenabled
                              ? 'Disable '
                              : AppStrings.enable.getString(context),
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          AppStrings.twofactorauthentication.getString(context),
                          style: TextStyle(
                            color:twoFAenabled?Colors.red: AppColors.kPrimaryColor2,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 23.w),
                Expanded(
                  child: CustomButton(
                    color:twoFAenabled?Colors.red: AppColors.kPrimaryColor2,
                    buttonText: twoFAenabled
                        ? "DISABLE"
                        : AppStrings.enablecap.getString(context),
                    width: 150.w,
                    height: 40.h,
                    borderRadius: 30.r,
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final token = prefs.getString(PrefKeys.kToken);
                      if (token != null) {
                        showConfirmPasswordDialog(context, token);
                      } else {
                        debugPrint('token is null');
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.accountclosure.getString(context),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      AppStrings.deleteyouraccountanddata.getString(context),
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(width: 45.w),
                Expanded(
                  child: CustomButton(
                    color: Colors.red,
                    buttonText: AppStrings.deletecap.getString(context),
                    width: 150.w,
                    height: 40.h,
                    borderRadius: 30.r,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => DeleteMyAccountCubit(),
                            child: const _DeleteMyAccountDialog(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Future<void> disableTwoFactorAuth(BuildContext context, String token) async {
    final dio = Dio();
    try {
      await dio.delete(
        '${ApiEndPoints.baseUrl}/user/two-factor-authentication',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('2FA disabled successfully'),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to disable 2FA: $e'),
              backgroundColor: Colors.red),
        );
      }
    }
  }
}

class _DeleteMyAccountDialog extends StatelessWidget {
  const _DeleteMyAccountDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
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
                    AppStrings.areyousureyouwanttodeleteyouraccount
                        .getString(context),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        color: AppColors.kPrimaryColor,
                        buttonText: AppStrings.yes.getString(context),
                        height: 30.h,
                        borderRadius: 30.r,
                        width: 80.w,
                        onTap: () async {
                          await context
                              .read<DeleteMyAccountCubit>()
                              .deleteAccount();

                          if (context.mounted) {
                            GoRouter.of(context).go(
                              LoginScreen.route,
                              extra: const LogInScreenArgs(),
                            );
                            await CacheData.deleteData(key: PrefKeys.kToken);
                          }
                        },
                      ),
                      CustomButton(
                        color: Colors.red,
                        buttonText: AppStrings.no.getString(context),
                        height: 30.h,
                        borderRadius: 30.r,
                        width: 80.w,
                        onTap: () {
                          GoRouter.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
