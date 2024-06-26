import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:genix/features/comments%20section/views/widgets/reply_bubble.dart';

class RepliesList extends StatelessWidget {
  const RepliesList({
    super.key,
    required this.replies,
    required this.onTap,
  });

  final List<String> replies;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            CustomReplyBubble(
              replyText: replies[index],
              onTap: onTap,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        );
      },
      itemCount: replies.length,
    );
  }
}
