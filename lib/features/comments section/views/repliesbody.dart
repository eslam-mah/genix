import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/comments%20section/widgets/commentbubble.dart';
import 'package:genix/features/comments%20section/widgets/replieslist.dart';

class RepliesBody extends StatefulWidget {
  const RepliesBody({super.key});

  @override
  State<RepliesBody> createState() => _RepliesBodyState();
}

class _RepliesBodyState extends State<RepliesBody> {
  List<String> replies = [];
  TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void focusTextField() {
    focusNode.requestFocus();
  }

  Future<void> addreply() async {
    String replyText = textEditingController.text.trim();
    if (replyText.isNotEmpty) {
      setState(() {
        replies.add(replyText);
        textEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Replies'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  CustomCommentBubble(
                      onTap: focusTextField, commentText: 'commentText'),
                  Expanded(
                    child: RepliesList(
                      replies: replies,
                      onTap: focusTextField,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                child: TextField(
                  focusNode: focusNode,
                  controller: textEditingController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Reply to Name comment',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13.r),
                        borderSide: const BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: AppColors.kPrimaryColor2,
                        )),
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
                          addreply();
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
