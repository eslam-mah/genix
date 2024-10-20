import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:shimmer/shimmer.dart';

class DrawerProfileShimmer extends StatelessWidget {
  const DrawerProfileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ThemeCubit().state == ThemeState.dark
          ? Colors.grey[800]!
          : Colors.grey[300]!,
      highlightColor: ThemeCubit().state == ThemeState.dark
          ? Colors.grey[600]!
          : Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: ThemeCubit().state == ThemeState.dark
                    ? Colors.grey[700]
                    : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 3.w),
            // Notification Text and Time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notification text placeholder
                  Container(
                    width: double.infinity,
                    height: 5.h,
                    color: ThemeCubit().state == ThemeState.dark
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                  SizedBox(height: 3.h),
                  // Shorter placeholder for time
                  Container(
                    width: 30.w,
                    height: 4.h,
                    color: ThemeCubit().state == ThemeState.dark
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
