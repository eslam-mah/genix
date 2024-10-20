// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/drawer/view%20model/log_out_cubit/log_out_cubit.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customlisttile.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/settings%20screen/views/view/settings_page.dart';

class CustomDrawerWidget extends StatelessWidget {
  final bool isNightMode;
  const CustomDrawerWidget({
    super.key,
    required this.isNightMode,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 240.w,
        child: Drawer(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CustomUserProfileImage(image: '', isActive: true),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Radu'),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 4,
                          ),
                          SizedBox(width: 10.w),
                          const Text(
                            'Active',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.kPrimaryColor2,
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.h),
              CustomListTile(
                icon: FontAwesomeIcons.gear,
                text: 'Settings',
                onTap: () {
                  GoRouter.of(context).push(SettingsPage.route);
                },
              ),
              CustomListTile(
                icon: FontAwesomeIcons.coins,
                text: 'Get coins',
                onTap: () {},
              ),
              // CustomListTile(
              //   icon: FontAwesomeIcons.fileShield,
              //   text: 'Help & FAQ',
              //   onTap: () {},
              // ),
              CustomListTile(
                icon: FontAwesomeIcons.arrowUp,
                text: 'Promotions',
                onTap: () {},
              ),
              CustomListTile(
                icon: FontAwesomeIcons.key,
                text: 'Lock screen',
                onTap: () {},
              ),
              CustomListTile(
                icon: FontAwesomeIcons.rightFromBracket,
                text: 'Logout',
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return const _LogOutDialog();
                      });
                },
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    FontAwesomeIcons.solidMoon,
                    size: 20.sp,
                  ),
                  Text(
                    'Dark mode',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  Switch(
                    value: ThemeCubit().state == ThemeState.dark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                      GoRouter.of(context).pop();
                    },
                    activeColor: Colors.white,
                    activeTrackColor: ThemeCubit().state == ThemeState.dark
                        ? AppColors.kPrimaryColor2
                        : Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogOutDialog extends StatelessWidget {
  const _LogOutDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocBuilder<LogOutCubit, LogOutState>(
        builder: (context, state) {
          if (state is LogOutLoading) {
            return SizedBox(
              height: 100.h,
              width: 300.w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          } else {
            return SizedBox(
              height: 100.h,
              width: 300.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Are you sure you want to log out?',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: 'Yes',
                          height: 30.h,
                          borderRadius: 30.r,
                          width: 80.w,
                          onTap: () async {
                            await context.read<LogOutCubit>().logOut();

                            // ignore: use_build_context_synchronously
                            GoRouter.of(context).go(LoginScreen.route,
                                extra: const LogInScreenArgs());
                          }),
                      CustomButton(
                          color: Colors.red,
                          buttonText: 'no',
                          height: 30.h,
                          borderRadius: 30.r,
                          width: 80.w,
                          onTap: () {
                            GoRouter.of(context).pop();
                          })
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
