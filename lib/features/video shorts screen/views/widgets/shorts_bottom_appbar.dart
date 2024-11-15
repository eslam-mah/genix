import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/customappbaricon.dart';
import 'package:genix/features/home%20screen/views/view/homebody.dart';
import 'package:genix/features/notifications%20screen/views/view/notifications_page.dart';
import 'package:genix/features/profile%20screen/views/view/my_profile_page.dart';

import 'package:go_router/go_router.dart';

class CustomShortsBottomAppBar extends StatelessWidget {
  const CustomShortsBottomAppBar({
    super.key,
    required this.isNightMood,
  });
  final bool isNightMood;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 55.h,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.house,
            onTap: () {
              GoRouter.of(context).go(HomePage.routeName);
            },
            size: 18.sp,
          ),
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.solidBell,
            onTap: () {
              GoRouter.of(context).push(
                NotificationsPage.route,
              );
            },
            size: 18.sp,
          ),
          SizedBox(
            width: 20.w,
          ),
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.inbox,
            onTap: () {},
            size: 18.sp,
          ),
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.solidUser,
            onTap: () {
              GoRouter.of(context).push(
                MyProfilePage.route,
              );
            },
            size: 18.sp,
          ),
        ],
      ),
    );
  }
}
