import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class StoryShimmer extends StatelessWidget {
  const StoryShimmer({
    super.key,
    required this.isNightModeEnabled,
  });

  final bool isNightModeEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
            baseColor:
                isNightModeEnabled ? Colors.grey[800]! : Colors.grey[300]!,
            highlightColor:
                isNightModeEnabled ? Colors.grey[600]! : Colors.grey[100]!,
            child: Row(
              children: [
                // Circular profile picture
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
