import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              const SnackBar(content: Text('These credentials do not match')),
            );
          } else if (state is LogInSuccess) {
            setState(() {
              isLoading = false;
            });
            if (homeState is FirstLoadSuccess &&
                homeState.status == HttpResponseStatus.success) {
              GoRouter.of(context).go(HomePage.routeName);
              print(homeState.status);
            } else if (homeState is FirstLoadError ||
                homeState is FirstLoadSuccess &&
                    homeState.firstLoad.data.user?.verified == false) {
              GoRouter.of(context).go(VerificationScreen.routeName);
            } else {
              print(state);
              print(homeState);
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
                          GoRouter.of(context).push(RegisterBody.route);
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
      ),
    );
  }
}
