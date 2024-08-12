import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/features/comments%20section/views/widgets/comment_bubble.dart';
import 'package:go_router/go_router.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
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
            // CustomCommentBubble(
            //   commentText: comments[index],
            //   onTap: () {
            //     GoRouter.of(context).push(Rout.kReplies);
            //   }, postsModel: '',
            // ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                GoRouter.of(context).push(Rout.kReplies);
              },
              child: SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.w,
                    ),
                    const Text('View all replies'),
                  ],
                ),
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
