import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';

import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:go_router/go_router.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    super.initState();
    goToAuth();
  }

  void goToAuth() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isAuthenticated = await _checkAuthStatus();

    if (isAuthenticated) {
      // Navigate to Home Screen if user is authenticated
      GoRouter.of(context).push(Rout.kHome);
    } else {
      // Navigate to Login Screen if user is not authenticated
      GoRouter.of(context).push(LoginScreen.route, extra: LogInScreenArgs());
    }
  }

  Future<bool> _checkAuthStatus() async {
    print("Checking authentication status...");
    if (CacheData.isUserSignedIn()) {
      try {
        print("Token found. Checking authentication status...");
        final response = await HttpHelper.getData(
          linkUrl: "https://api.genix.social/api/firstload",
          token: CacheData.getCustomToken()!,
        );

        if (response.statusCode == 202) {
          var data = jsonDecode(response.body);
          print("Authentication response: $data");
          return data['success'] == true && data['data']['user']['id'] != null;
        } else if (response.statusCode == 401) {
          print("Token expired. Refreshing token...");
          final newToken = await HttpHelper.refreshToken();
          if (newToken != null) {
            await CacheData.setData(key: 'customToken', value: newToken);
            return await _checkAuthStatus();
          } else {
            await CacheData.clearData();
            return false;
          }
        }
      } catch (e) {
        // Handle error, possibly no internet connection
        print("Error during authentication check: $e");
        return false;
      }
    }
    print("No valid token found.");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Center(
        child: SizedBox(
          width: 110.w,
          height: 110.h,
          child: Image.asset(AppImages.kWhiteLogo),
        ),
      ),
    );
  }
}
