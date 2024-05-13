import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';

class ProfilesCard extends StatelessWidget {
  const ProfilesCard({
    super.key,
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
              const CustomUserProfileImage(),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'user name',
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    Text(
                      'hey iam using genix it is the best social media website ever ',
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
