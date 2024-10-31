import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/constant.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/features/drawer/view%20model/log_out_cubit/log_out_cubit.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';
import 'package:genix/features/lock%20screen/view%20model/get%20lock/get_lock_cubit.dart';
import 'package:genix/features/login%20screen/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';

import 'core/services/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await CacheData.cacheInitialization();
  Stripe.publishableKey = Constant.stripePublishableKey;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((v) {
    runApp(const Genix());
  });
}

class Genix extends StatelessWidget {
  const Genix({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => FirstLoadCubit()),
            BlocProvider(create: (context) => ThemeCubit()),
            BlocProvider(create: (context) => LogOutCubit()),
            BlocProvider(create: (context) => GetMyAccountDetailsCubit()),
            BlocProvider(create: (context) => GetLockCubit()),
            BlocProvider(create: (context) => LogInCubit()),
            BlocProvider(create: (context) => GetNewsFeedPostsCubit()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                theme: themeState == ThemeState.light
                    ? ThemeData.light().copyWith(
                        bottomAppBarTheme: const BottomAppBarTheme(
                          color: AppColors.kAppBar2Color,
                        ),
                        appBarTheme: const AppBarTheme(
                            backgroundColor: AppColors.kAppBar2Color),
                      )
                    : ThemeData.dark().copyWith(
                        drawerTheme: const DrawerThemeData(
                          backgroundColor: DarkModeColors.kItemColorDark,
                        ),
                        bottomAppBarTheme: const BottomAppBarTheme(
                          color: DarkModeColors.kItemColorDark3,
                        ),
                        appBarTheme: const AppBarTheme(
                          backgroundColor: DarkModeColors.kItemColorDark3,
                        ),
                        scaffoldBackgroundColor:
                            DarkModeColors.kBackGroundDark),
                routerConfig: Rout.router,
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        );
      },
    );
  }
}
