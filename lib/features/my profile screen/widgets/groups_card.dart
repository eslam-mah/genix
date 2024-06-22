import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';

class GroupsCard extends StatelessWidget {
  const GroupsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      color: AppColors.kAppBar2Color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Image.asset(
              AppImages.kLogo,
              height: 50.h,
            ),
          ),
          Expanded(
            child: Text(
              'Genix newsfeed',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 4.h),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 55.w),
                Icon(
                  FontAwesomeIcons.users,
                  size: 16.sp,
                  color: Colors.green,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    '8',
                    style: TextStyle(fontSize: 14.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
