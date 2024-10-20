import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ThemeCubit().state == ThemeState.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _shimmerHeader(isDarkMode),
            SizedBox(height: 16.h),
            _shimmerStats(isDarkMode),
            SizedBox(height: 16.h),
            _shimmerSections(isDarkMode, 'Photos'),
            SizedBox(height: 16.h),
            _shimmerSections(isDarkMode, 'Videos'),
            SizedBox(height: 16.h),
            _shimmerSections(isDarkMode, 'Shorts'),
            SizedBox(height: 16.h),
            _shimmerSections(isDarkMode, 'Saved Shorts'),
            SizedBox(height: 16.h),
            _shimmerSections(isDarkMode, 'Followers'),
            SizedBox(height: 16.h),
            _shimmerSections(isDarkMode, 'Groups'),
            SizedBox(height: 16.h),
            _shimmerRecentPosts(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _shimmerHeader(bool isDarkMode) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 400.h,
        color: Colors.grey,
      ),
    );
  }

  Widget _shimmerStats(bool isDarkMode) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) {
          return Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20.r,
                child: Icon(
                  FontAwesomeIcons.solidCircle,
                  size: 15.r,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 30.w,
                height: 10.h,
                color: Colors.grey,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _shimmerSections(bool isDarkMode, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100.w,
                height: 20.h,
                color: Colors.grey,
              ),
              Container(
                width: 50.w,
                height: 20.h,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Shimmer.fromColors(
          baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
          highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
          child: Container(
            height: 100.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _shimmerRecentPosts(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            width: 150.w,
            height: 20.h,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 8.h),
        Shimmer.fromColors(
          baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
          highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
          child: Column(
            children: List.generate(3, (index) {
              return Container(
                height: 150.h,
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                color: Colors.grey,
              );
            }),
          ),
        ),
      ],
    );
  }
}
