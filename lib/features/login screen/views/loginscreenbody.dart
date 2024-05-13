import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customiconbutton.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/customtextfield.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Center(
                child: SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: Image.asset(AppImages.kLogo))),
            SizedBox(
              height: 60.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30.w,
                ),
                Icon(
                  FontAwesomeIcons.key,
                  size: 30.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Login',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
                hintText: 'E-mail',
                readOnly: false,
                onTap: () {},
                controller: TextEditingController()),
            SizedBox(
              height: 26.h,
            ),
            CustomTextField(
                hintText: 'password',
                readOnly: false,
                onTap: () {},
                controller: TextEditingController()),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30.w,
                ),
                Text(
                  'Remember me',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(
                  width: 160.w,
                ),
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeTrackColor: AppColors.kPrimaryColor2,
                )
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            CustomButton(
              onTap: () {
                GoRouter.of(context).pushReplacement(Rout.kHome);
              },
              color: AppColors.kPrimaryColor2,
              width: 320.w,
              height: 40.w,
              buttonText: 'Login',
              borderRadius: 50.r,
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              child: Text(
                'Forgot password?',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  onTap: () {},
                  width: 100.w,
                  hieght: 33.h,
                  icon: FontAwesomeIcons.key,
                  borderRadius: 50.r,
                  buttonText: 'Sign in',
                  color: AppColors.kPrimaryColor2,
                ),
                SizedBox(
                  width: 18.w,
                ),
                CustomIconButton(
                  onTap: () {
                    GoRouter.of(context).push(Rout.kRegister);
                  },
                  width: 100.w,
                  hieght: 33.h,
                  icon: FontAwesomeIcons.penRuler,
                  borderRadius: 50.r,
                  buttonText: 'Sign up',
                  color: Colors.black,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
