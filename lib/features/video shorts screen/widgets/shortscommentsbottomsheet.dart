import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/video%20shorts%20screen/widgets/shortscommentslist.dart';

Future<dynamic> shortsCommentBottomSheet(
    BuildContext context, StateSetter setState) {
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

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.kPostColor,
      enableDrag: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Comments',
                                style: TextStyle(fontSize: 19.sp),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                '0',
                                style: TextStyle(fontSize: 13.sp),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.grey,
                            height: 1.h,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                            child: ShortsCommentsList(comments: comments),
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
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5)),
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            disabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  addComment();
                                });
                              },
                              icon:
                                  const Icon(FontAwesomeIcons.solidPaperPlane),
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
            ),
          );
        });
      });
}
