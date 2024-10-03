import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';

class CustomLoadingPage extends StatelessWidget {
  const CustomLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80.w,
              height: 80.h,
              child: Image.asset(AppImages.kLogo),
            ),
            SizedBox(
              height: 8.h,
            ),
            const CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
