import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmerEffect extends StatelessWidget {
  const PostShimmerEffect({
    super.key,
    required this.isNightModeEnabled,
  });

  final bool isNightModeEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: isNightModeEnabled ? Colors.grey[800]! : Colors.grey[300]!,
          highlightColor:
              isNightModeEnabled ? Colors.grey[600]! : Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture and name shimmer
              Row(
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
                  SizedBox(width: 10.w),
                  // Name shimmer
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.w,
                        height: 15.h,
                        color: isNightModeEnabled
                            ? Colors.grey[700]
                            : Colors.grey[300],
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: 100.w,
                        height: 15.h,
                        color: isNightModeEnabled
                            ? Colors.grey[700]
                            : Colors.grey[300],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Post content shimmer
              Container(
                width: double.infinity,
                height: 200.h,
                color: isNightModeEnabled ? Colors.grey[700] : Colors.grey[300],
              ),
              SizedBox(height: 10.h),
              // Post footer (like, comment, share buttons) shimmer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80.w,
                    height: 20.h,
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                  Container(
                    width: 80.w,
                    height: 20.h,
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                  Container(
                    width: 80.w,
                    height: 20.h,
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                ],
              ),
            ],
          ),
        ),
        Shimmer.fromColors(
          baseColor: isNightModeEnabled ? Colors.grey[800]! : Colors.grey[300]!,
          highlightColor:
              isNightModeEnabled ? Colors.grey[600]! : Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture and name shimmer
              Row(
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
                  SizedBox(width: 10.w),
                  // Name shimmer
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.w,
                        height: 15.h,
                        color: isNightModeEnabled
                            ? Colors.grey[700]
                            : Colors.grey[300],
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: 100.w,
                        height: 15.h,
                        color: isNightModeEnabled
                            ? Colors.grey[700]
                            : Colors.grey[300],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Post content shimmer
              Container(
                width: double.infinity,
                height: 200.h,
                color: isNightModeEnabled ? Colors.grey[700] : Colors.grey[300],
              ),
              SizedBox(height: 10.h),
              // Post footer (like, comment, share buttons) shimmer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80.w,
                    height: 20.h,
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                  Container(
                    width: 80.w,
                    height: 20.h,
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                  Container(
                    width: 80.w,
                    height: 20.h,
                    color: isNightModeEnabled
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
