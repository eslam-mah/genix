import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';

import '../../../../core/localization/all_app_strings.dart';

class ShortsCommentBubble extends StatelessWidget {
  const ShortsCommentBubble({super.key, required this.commentText});
  final String commentText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CustomUserProfileImage(
              isActive: true,
              image: '',
              showname: '',
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Container(
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.name.getString(context)),
                          Text(AppStrings.onedayago.getString(context)),
                        ],
                      ),
                      Text(
                        commentText,
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
