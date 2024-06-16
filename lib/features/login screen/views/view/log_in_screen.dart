import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customiconbutton.dart';
import 'package:genix/features/login%20screen/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:go_router/go_router.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    logInCubit = BlocProvider.of<LogInCubit>(context);
  }

  void logIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await logInCubit.logIn(email: email, password: password);
    } else {
      // Show error message or handle empty fields
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is LogInError) {
            setState(() {
              isLoading = false;
            });
          } else if (state is LogInSuccess) {
            setState(() {
              isLoading = false;
            });
            GoRouter.of(context).go(Rout.kHome); // Adjust the route accordingly
          }
        },
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
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
                      'Login',
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  isObscure: false,
                  onTap: () {},
                  hintText: 'E-mail',
                  readOnly: false,
                  controller: emailController,
                ),
                SizedBox(height: 26.h),
                CustomTextField(
                  isObscure: true,
                  onTap: () {},
                  hintText: 'Password',
                  readOnly: false,
                  controller: passwordController,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    SizedBox(width: 30.w),
                    Text('Remember me', style: TextStyle(fontSize: 14.sp)),
                    Spacer(),
                    Switch(
                      value: true,
                      onChanged: (value) {},
                      activeTrackColor: AppColors.kPrimaryColor2,
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  onTap: logIn,
                  color: AppColors.kPrimaryColor2,
                  width: 320.w,
                  height: 40.w,
                  buttonText: 'Login',
                  borderRadius: 50.r,
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {
                    // Handle forgot password action
                  },
                  child: Text(
                    'Forgot password?',
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
                      buttonText: 'Sign in',
                      color: AppColors.kPrimaryColor2,
                    ),
                    SizedBox(width: 18.w),
                    CustomIconButton(
                      onTap: () {
                        GoRouter.of(context).push(Rout.kRegister);
                      },
                      width: 100.w,
                      height: 33.h,
                      icon: FontAwesomeIcons.penRuler,
                      borderRadius: 50.r,
                      buttonText: 'Sign up',
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
