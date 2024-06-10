import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';

import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customiconbutton.dart';
import 'package:genix/core/widgets/customtextfield.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  TextEditingController dateController = TextEditingController();
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
                  FontAwesomeIcons.penRuler,
                  size: 30.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Register',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
                hintText: 'Your name',
                readOnly: false,
                onTap: () {},
                controller: TextEditingController()),
            SizedBox(
              height: 26.h,
            ),
            CustomTextField(
                hintText: 'Username',
                readOnly: false,
                onTap: () {},
                controller: TextEditingController()),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
                hintText: 'E-mail',
                readOnly: false,
                onTap: () {},
                controller: TextEditingController()),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
                hintText: 'password',
                readOnly: false,
                onTap: () {},
                controller: TextEditingController()),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              hintText: 'Retype password',
              readOnly: false,
              onTap: () {},
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              controller: dateController,
              hintText: 'Date',
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now());
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy/MM/dd').format(pickedDate);
                  setState(() {
                    dateController.text = formattedDate;
                  });
                }
              },
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
              onTap: () {},
              color: AppColors.kPrimaryColor2,
              width: 320.w,
              height: 40.w,
              buttonText: 'Signup',
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
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  width: 100.w,
                  height: 33.h,
                  icon: FontAwesomeIcons.key,
                  borderRadius: 50.r,
                  buttonText: 'Sign in',
                  color: Colors.black,
                ),
                SizedBox(
                  width: 18.w,
                ),
                CustomIconButton(
                  onTap: () {},
                  width: 100.w,
                  height: 33.h,
                  icon: FontAwesomeIcons.penRuler,
                  borderRadius: 50.r,
                  buttonText: 'Sign up',
                  color: AppColors.kPrimaryColor2,
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
