import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';

class ProfilesCard extends StatelessWidget {
  final String imageUrl;
  final String showName;
  final String userBio;
  final bool isActive;
  final String userName;
  const ProfilesCard({
    super.key,
    required this.imageUrl,
    required this.showName,
    required this.userBio,
    required this.isActive,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(ProfilePage.route, extra: userName);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 50.h,
          minWidth: 350.w,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.r),
            color: ThemeCubit().state == ThemeState.dark
                ? DarkModeColors.kItemColorDark
                : AppColors.kAppBar2Color,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              children: [
                SizedBox(
                  width: 12.w,
                ),
                CustomUserProfileImage(
                  image: imageUrl,
                  isActive: isActive,
                  showname: showName,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        showName,
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      Text(
                        userBio,
                        style: TextStyle(fontSize: 11.sp),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
