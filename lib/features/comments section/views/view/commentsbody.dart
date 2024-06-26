import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/features/comments%20section/views/widgets/comments_list.dart';

class CommentsBody extends StatefulWidget {
  const CommentsBody({super.key});

  @override
  State<CommentsBody> createState() => _CommentsBodyState();
}

class _CommentsBodyState extends State<CommentsBody> {
  List<String> comments = [];
  TextEditingController textEditingController = TextEditingController();
  Future<void> addComment() async {
    String commentText = textEditingController.text.trim();
    if (commentText.isNotEmpty) {
      setState(() {
        comments.add(commentText);
        textEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: CommentsList(comments: comments),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                child: TextField(
                  controller: textEditingController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13.r),
                        borderSide: const BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: AppColors.kPrimaryColor2,
                        )),
                    hintText: 'Reply to Name post',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    disabledBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          addComment();
                        });
                      },
                      icon: const Icon(FontAwesomeIcons.solidPaperPlane),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
