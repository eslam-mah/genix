import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/customappbaricon.dart';
import 'package:genix/features/notifications%20screen/views/view/notifications_page.dart';

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
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.house,
            onTap: () {
              GoRouter.of(context).push(Rout.kHome);
            },
            size: 18.sp,
          ),
          CustomAppBarIcon(
            color: AppColors.kPrimaryColor2,
            icon: FontAwesomeIcons.solidBell,
            onTap: () {
              GoRouter.of(context).push(NotificationsPage.route,
                  extra: NotificationsPageArgs());
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
            onTap: () {},
            size: 18.sp,
          ),
        ],
      ),
    );
  }
}
