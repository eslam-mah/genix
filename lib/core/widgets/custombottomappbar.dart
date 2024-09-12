import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customappbaricon.dart';
import 'package:genix/features/home%20screen/views/view/homebody.dart';
import 'package:genix/features/notifications%20screen/views/view/notifications_page.dart';
import 'package:genix/features/profile%20screen/views/view/my_profile_page.dart';

import 'package:go_router/go_router.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    required this.isNightMode,
    this.homeEnabled = true,
    this.notificationsEnabled = true,
    this.messagesEnabled = true,
    this.profileEnabled = true,
  });
  final bool isNightMode;
  final bool? homeEnabled;
  final bool? notificationsEnabled;
  final bool? messagesEnabled;
  final bool? profileEnabled;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 55.h,
      elevation: 0,
      color: AppColors.kAppBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.house,
            onTap: homeEnabled ?? true
                ? () {
                    GoRouter.of(context).push(
                      HomePage.routeName,
                    );
                  }
                : null,
            size: 18.sp,
          ),
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.solidBell,
            onTap: notificationsEnabled ?? true
                ? () {
                    GoRouter.of(context).push(
                      NotificationsPage.route,
                    );
                  }
                : null,
            size: 18.sp,
          ),
          SizedBox(
            width: 20.w,
          ),
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.inbox,
            onTap: messagesEnabled ?? true ? () {} : null,
            size: 18.sp,
          ),
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.solidUser,
            onTap: profileEnabled ?? true
                ? () {
                    GoRouter.of(context).push(
                      MyProfilePage.route,
                    );
                  }
                : null,
            size: 18.sp,
          ),
        ],
      ),
    );
  }
}
