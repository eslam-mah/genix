import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:shimmer/shimmer.dart';

class GroupsCard extends StatelessWidget {
  final String photoUrl;
  final String gpName;
  final int membersNumber;
  final bool isNightMode;
  const GroupsCard({
    super.key,
    required this.photoUrl,
    required this.gpName,
    required this.membersNumber,
    required this.isNightMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      color: isNightMode ? DarkModeColors.kItemColorDark : Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: CachedNetworkImage(
              width: 50.w,
              height: 50.h,
              imageUrl: photoUrl,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: isNightMode ? Colors.transparent : Colors.grey[300]!,
                highlightColor:
                    isNightMode ? Colors.transparent : Colors.grey[100]!,
                child: Container(
                  color: isNightMode
                      ? DarkModeColors.kItemColorDark
                      : Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color:
                    isNightMode ? DarkModeColors.kItemColorDark : Colors.white,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.kLogo,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              gpName,
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
                    membersNumber.toString(),
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
