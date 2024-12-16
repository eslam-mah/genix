import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/services/http_reponse_status.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customiconbutton.dart';
import 'package:genix/features/home%20screen/views/view/homebody.dart';
import 'package:genix/features/login%20screen/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:genix/features/register%20screen/views/register_page.dart';
import 'package:genix/features/register%20screen/views/verification_screen.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';
import 'package:go_router/go_router.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/localization/all_app_strings.dart';
import '../../../../core/widgets/customtextfield.dart';

class LogInScreenArgs {
  const LogInScreenArgs();
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.args});
  static const String route = '/login';

  final LogInScreenArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogInCubit(),
      child: LoginScreenBody(args: args),
    );
  }
}

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key, required this.args});

  final LogInScreenArgs args;

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  late LogInCubit logInCubit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    logInCubit = BlocProvider.of<LogInCubit>(context);
    context.read<FirstLoadCubit>().firstLoad();
  }
  void logIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      final email = emailController.text;
      final password = passwordController.text;

      await logInCubit.logIn(email: email, password: password);
    }
  }


  void showTwoFactorDialog(BuildContext context, String email, String password) {
    final TextEditingController codeController = TextEditingController();

    showCupertinoModalPopup(
      context: context,
      builder: (dialogContext) => Container(
        color: CupertinoColors.systemBackground.resolveFrom(dialogContext),
        child: CupertinoAlertDialog(
          title: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Icon(
                  CupertinoIcons.lock_shield,
                  size: 48,
                  color: CupertinoColors.systemBlue.resolveFrom(dialogContext),
                ),
              ),
              const Text(
                'Verification Required',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                'Enter the 6-digit code from your\nauthenticator app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.secondaryLabel.resolveFrom(dialogContext),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: CupertinoColors.tertiarySystemFill.resolveFrom(dialogContext),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CupertinoColors.systemGrey5.resolveFrom(dialogContext),
                    width: 0.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CupertinoTextField(
                    controller: codeController,
                    placeholder: '••••••',
                    decoration: null,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    style: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 8,
                      fontWeight: FontWeight.w500,
                    ),
                    placeholderStyle: TextStyle(
                      fontSize: 24,
                      letterSpacing: 8,
                      color: CupertinoColors.placeholderText.resolveFrom(dialogContext),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'The code expires in 30 seconds',
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.secondaryLabel.resolveFrom(dialogContext),
                ),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(dialogContext),
              isDestructiveAction: true,
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () async {
                final code = codeController.text.trim();
                if (code.isNotEmpty) {
                  await logInCubit.logIn(
                    email: email,
                    password: password,
                    code: code,
                  );
                  Navigator.pop(dialogContext);
                }
              },
              isDefaultAction: true,
              child: const Text(
                'Verify',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    // UserModel user;
    return Scaffold(
      body: BlocListener<LogInCubit, LogInState>(
        listener: (context, state) {
          final homeState = context.read<FirstLoadCubit>().state;
          if (state is LogInError) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(AppStrings.thesecredentialsdonotmatch.getString(context))),
            );
          } else if (state is LogInSuccess) {
            setState(() {
              isLoading = false;
            });
            if (homeState is FirstLoadSuccess &&
                homeState.status == HttpResponseStatus.success) {
              GoRouter.of(context).go(HomePage.routeName);
              if (kDebugMode) {
                print(homeState.status);
              }
            } else if (homeState is FirstLoadError ||
                homeState is FirstLoadSuccess &&
                    homeState.firstLoad.data.user?.verified == false) {
              GoRouter.of(context).go(VerificationScreen.routeName);
            } else {
              if (kDebugMode) {
                print(state);
              }
              if (kDebugMode) {
                print(homeState);
              }
              GoRouter.of(context).push(Rout.kLoadingPage);
            }
          }
        },
        child: ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: AppColors.kPrimaryColor,
          ),
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Center(
                    child: SizedBox(
                      width: 80.w,
                      height: 80.h,
                      child: Image.asset(AppImages.kLogo),
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Row(
                    children: [
                      SizedBox(width: 30.w),
                      Icon(FontAwesomeIcons.key, size: 30.sp),
                      SizedBox(width: 10.w),
                      Text(
                        AppStrings.login.getString(context),
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    isObscure: false,
                    onTap: () {},
                    hintText: AppStrings.email.getString(context),
                    readOnly: false,
                    controller: emailController,
                  ),
                  SizedBox(height: 26.h),
                  CustomTextField(
                    isObscure: true,
                    onTap: () {},
                    hintText: AppStrings.password.getString(context),
                    readOnly: false,
                    controller: passwordController,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 30.w),
                      Text(AppStrings.rememberme.getString(context), style: TextStyle(fontSize: 14.sp)),
                      const Spacer(),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        activeTrackColor: AppColors.kPrimaryColor2,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 50.h),
                BlocConsumer<LogInCubit, LogInState>(
                  listener: (context, state) {
                    if (state is LogInSuccess) {
                      // Navigate to the home screen
                      Navigator.pushReplacementNamed(context, '/home');
                    } else if (state is LogInTwoFactorRequired) {
                      // Show 2FA dialog
                      showTwoFactorDialog(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                    } else if (state is LogInError) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      onTap: (){
                        state is LogInLoading ? null : logIn();
                      },
                      color: AppColors.kPrimaryColor2,
                      width: 320.w,
                      height: 40.w,
                      buttonText: state is LogInLoading
                          ? 'Loading...' // Show loading text if login in progress
                          : AppStrings.login.getString(context),
                      borderRadius: 50.r,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      // Handle forgot password action
                    },
                    child: Text(
                      AppStrings.forgetpassword.getString(context),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        onTap: () {},
                        width: 100.w,
                        height: 33.h,
                        icon: FontAwesomeIcons.key,
                        borderRadius: 50.r,
                        buttonText:AppStrings.signin.getString(context),
                        color: AppColors.kPrimaryColor2,
                      ),
                      SizedBox(width: 18.w),
                      CustomIconButton(
                        onTap: () {
                          GoRouter.of(context).push(RegisterBody.route);
                        },
                        width: 100.w,
                        height: 33.h,
                        icon: FontAwesomeIcons.penRuler,
                        borderRadius: 50.r,
                        buttonText: AppStrings.signup.getString(context),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
