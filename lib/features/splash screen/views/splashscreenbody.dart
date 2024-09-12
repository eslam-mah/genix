import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/home%20screen/views/view/homebody.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';
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
    _initAuthCheck();
  }

  void _initAuthCheck() async {
    await Future.delayed(const Duration(seconds: 3));
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    context.read<FirstLoadCubit>().firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Center(
        child: BlocListener<FirstLoadCubit, FirstLoadState>(
          listener: (context, state) {
            if (state is FirstLoadSuccess &&
                CacheData.getData(key: 'auth_token') != null) {
              GoRouter.of(context).push(HomePage.routeName);
            } else if (state is FirstLoadError) {
              GoRouter.of(context)
                  .push(LoginScreen.route, extra: LogInScreenArgs());
            } else if (CacheData.getData(key: 'auth_token') == null) {
              GoRouter.of(context)
                  .push(LoginScreen.route, extra: LogInScreenArgs());
            }
          },
          child: SizedBox(
            width: 110.w,
            height: 110.h,
            child: Image.asset(AppImages.kWhiteLogo),
          ),
        ),
      ),
    );
  }
}
