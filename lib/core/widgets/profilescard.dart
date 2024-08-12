import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';

class ProfilesCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String userBio;
  final bool isActive;
  const ProfilesCard({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.userBio,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 50.h,
        minWidth: 350.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: AppColors.kAppBar2Color,
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
                      userName,
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
    );
  }
}
