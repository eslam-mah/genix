// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/drawer/view%20model/log_out_cubit/log_out_cubit.dart';
import 'package:genix/features/drawer/view/widget/drawer_profile_shimmer.dart';
import 'package:genix/features/lock%20screen/view%20model/post%20lock/post_lock_cubit.dart';
import 'package:genix/features/lock%20screen/views/lock_page.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customlisttile.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/settings%20screen/views/view/settings_page.dart';

import '../../../core/localization/all_app_strings.dart';

class CustomDrawerWidget extends StatefulWidget {
  final bool isNightMode;
  const CustomDrawerWidget({
    super.key,
    required this.isNightMode,
  });

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  void initState() {
    super.initState();
    // context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 240.w,
        child: Drawer(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              BlocBuilder<GetMyAccountDetailsCubit, GetMyAccountDetailsState>(
                builder: (context, state) {
                  if (state is GetMyAccountDetailsSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomUserProfileImage(
                          image: state.account.data?.profileImg ?? '',
                          isActive: true,
                          showname: state.account.data?.showname ?? '',
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.account.data?.showname ?? '',
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      state.account.data?.isActive == true
                                          ? Colors.green
                                          : Colors.red,
                                  radius: 4.r,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  state.account.data?.isActive == true
                                      ? '${AppStrings.active.getString(context)}'
                                      : '${AppStrings.inactive.getString(context)}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                ),
                              ],
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            width: 40.w,
                            height: 23.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.kPrimaryColor2,
                            ),
                            child: Center(
                              child: Text(
                                '${AppStrings.edit.getString(context)}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (state is GetMyAccountDetailsLoading) {
                    return const DrawerProfileShimmer();
                  } else {
                    print(state);
                    return const SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: 30.h),
              CustomListTile(
                icon: FontAwesomeIcons.gear,
                text: '${AppStrings.settings.getString(context)}',
                onTap: () {
                  GoRouter.of(context).push(SettingsPage.route, extra: 0);
                },
              ),
              CustomListTile(
                icon: FontAwesomeIcons.coins,
                text: '${AppStrings.getcoins.getString(context)}',
                onTap: () {
                  GoRouter.of(context).push(SettingsPage.route, extra: 4);
                },
              ),
              // CustomListTile(
              //   icon: FontAwesomeIcons.fileShield,
              //   text: 'Help & FAQ',
              //   onTap: () {},
              // ),
              CustomListTile(
                icon: FontAwesomeIcons.arrowUp,
                text: '${AppStrings.promotions.getString(context)}',
                onTap: () {
                  GoRouter.of(context).push(Rout.kPromotionsScreen);
                },
              ),
              CustomListTile(
                icon: FontAwesomeIcons.key,
                text: '${AppStrings.lockscreen.getString(context)}',
                onTap: () async {
                  await context.read<PostLockCubit>().postLock();
                  GoRouter.of(context).go(LockPage.route);
                },
              ),
              CustomListTile(
                icon: FontAwesomeIcons.rightFromBracket,
                text: '${AppStrings.logout.getString(context)}',
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
                    '${AppStrings.darkmode.getString(context)}',
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
                    '${AppStrings.areyousureyouwanttologout.getString(context)}',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: '${AppStrings.yes.getString(context)}',
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
                          buttonText: '${AppStrings.no.getString(context)}',
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
