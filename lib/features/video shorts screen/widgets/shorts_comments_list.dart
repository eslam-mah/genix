import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/shorts_comment_bubble.dart';

class ShortsCommentsList extends StatelessWidget {
  const ShortsCommentsList({
    super.key,
    required this.comments,
  });

  final List<String> comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            ShortsCommentBubble(
              commentText: comments[index],
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    width: 50.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        );
      },
      itemCount: comments.length,
    );
  }
}
