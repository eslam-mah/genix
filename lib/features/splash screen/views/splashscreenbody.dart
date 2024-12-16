import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';
import 'package:genix/features/home%20screen/views/view/homebody.dart';
import 'package:genix/features/lock%20screen/view%20model/get%20lock/get_lock_cubit.dart';
import 'package:genix/features/lock%20screen/views/lock_page.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:genix/features/register%20screen/views/verification_screen.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';
import 'package:go_router/go_router.dart';
// import 'package:pusher_client/pusher_client.dart';

import '../../../core/agora/call_service.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  final CallService callService = CallService();

  void startCall(String token, String channelName) {
    callService.joinChannel(token, channelName);
  }

  void endCall() {
    callService.leaveChannel();
  }

  // late PusherClient pusher;
  // void initPusher() {
  //   pusher = PusherClient(
  //     "bea6d82af19725b37bd4",
  //     PusherOptions(cluster: "eu"),
  //   );

  //   pusher.connect();
  // }

  @override
  void initState() {
    super.initState();
    callService.initAgora();
    // initPusher();
    _initAuthCheck();
  }

  void _initAuthCheck() async {
    await Future.delayed(const Duration(seconds: 3));
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    context.read<FirstLoadCubit>().firstLoad();
    context.read<GetLockCubit>().getLock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Center(
        child: MultiBlocListener(
          listeners: [
            BlocListener<FirstLoadCubit, FirstLoadState>(
              listener: (context, state) {
                if (state is FirstLoadSuccess) {
                  final lockState = context.read<GetLockCubit>().state;
                  final token = CacheData.getData(key: PrefKeys.kToken);
                  final homeState =
                      context.read<GetMyAccountDetailsCubit>().state;
                  print(
                      '________________________${state.firstLoad.data.user?.verified}');
                  if (lockState is GetLockSuccess &&
                      lockState.data.data == true) {
                    GoRouter.of(context).go(LockPage.route);
                  } else if (token != null &&
                      state.firstLoad.data.user?.verified == false) {
                    GoRouter.of(context).go(VerificationScreen.routeName);
                  } else if (token != null &&
                      state.firstLoad.data.user?.verified == true) {
                    GoRouter.of(context).go(HomePage.routeName);
                  } else {
                    GoRouter.of(context)
                        .go(LoginScreen.route, extra: const LogInScreenArgs());
                  }
                } else if (state is FirstLoadError) {
                  GoRouter.of(context)
                      .push(LoginScreen.route, extra: const LogInScreenArgs());
                } else {
                  GoRouter.of(context).push(Rout.kLoadingPage);
                }
              },
            ),
            BlocListener<GetLockCubit, GetLockState>(
              listener: (context, lockState) {
                // This listener becomes a backup to handle direct lock state changes.
                if (lockState is GetLockSuccess &&
                    lockState.data.data == true) {
                  GoRouter.of(context).go(LockPage.route);
                }
              },
            ),
          ],
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
