import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsShimmer extends StatelessWidget {
  final bool isNightModeEnabled;

  const SettingsShimmer({Key? key, required this.isNightModeEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 1; i < 5; i++)
          _ShimmerItem(isNightModeEnabled: isNightModeEnabled),
      ],
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem({
    super.key,
    required this.isNightModeEnabled,
  });

  final bool isNightModeEnabled;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isNightModeEnabled ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor:
          isNightModeEnabled ? Colors.grey[600]! : Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: isNightModeEnabled ? Colors.grey[700] : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10.w),
            // Notification Text and Time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notification text placeholder
                  Container(
                    width: double.infinity,
                    height: 15.h,
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                  SizedBox(height: 8.h),
                  // Shorter placeholder for time
                  Container(
                    width: 100.w,
                    height: 12.h,
                    color: isNightModeEnabled
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
