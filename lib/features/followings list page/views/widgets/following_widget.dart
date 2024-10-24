import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/followings%20list%20page/data/models/followings_model.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';

class FollowingWidget extends StatelessWidget {
  final FollowingsModel user;
  const FollowingWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(ProfilePage.route, extra: user.user.username);
      },
      child: Container(
        height: 60.h,
        width: 350.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: ThemeCubit().state == ThemeState.dark
              ? DarkModeColors.kItemColorDark
              : AppColors.kPostColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            children: [
              SizedBox(
                width: 12.w,
              ),
              CustomUserProfileImage(
                image: user.user.profileImg,
                isActive: user.user.isActive,
                width: 40.w,
                height: 40.w,
                bottom: 15.w,
                right: 25.w,
                showname: user.user.showname,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user.user.showname,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  if (user.user.isVerified) ...[
                    SizedBox(
                      width: 7.w,
                    ),
                    Icon(
                      Icons.verified,
                      color: AppColors.kPrimaryColor,
                      size: 16.sp,
                    )
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
