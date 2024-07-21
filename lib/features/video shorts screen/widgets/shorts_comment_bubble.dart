import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';

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
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kAppBar2Color,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name'),
                          Text('1 day ago'),
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
