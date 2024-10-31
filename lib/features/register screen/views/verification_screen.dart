import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:genix/features/register%20screen/view%20model/verification_cubit/verification_cubit.dart';
import 'package:go_router/go_router.dart';

class VerificationScreen extends StatelessWidget {
  static const String routeName = '/verification_screen';
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationCubit, VerificationState>(
      listener: (context, state) {
        if (state is VerificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is VerificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 60.h, left: 10.w, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: SizedBox(
                      width: 80.w,
                      height: 80.h,
                      child: Image.asset(AppImages.kLogo))),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Verify Your Account',
                style: TextStyle(fontSize: 40.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'if you have\'t received a link please click here',
                style: TextStyle(fontSize: 15.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                  buttonText: 'Send Verification Link',
                  height: 40.h,
                  width: 180.w,
                  color: AppColors.kPrimaryColor,
                  borderRadius: 10.r,
                  onTap: () {
                    context.read<VerificationCubit>().verifyEmail();
                  }),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'if you have already received a link or if you have an account , log in now',
                style: TextStyle(fontSize: 15.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                  buttonText: 'Log In',
                  height: 40.h,
                  width: 100.w,
                  color: AppColors.kPrimaryColor,
                  borderRadius: 10.r,
                  onTap: () {
                    GoRouter.of(context).push(LoginScreen.route,
                        extra: const LogInScreenArgs());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
