import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/custom_user_profile_image.dart';

Future<dynamic> commentsBottomSheet(BuildContext context) {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();
  List<String> comments = [];
  Map<String, List<String>> commentReplies = {};

  bool isReactedOnComment = false;
  bool reactionView = false;
  // bool isReactedOnReply = false;

  Future<void> addComment(StateSetter updateState) async {
    String commentText = textEditingController.text.trim();
    if (commentText.isNotEmpty) {
      updateState(() {
        comments.add(commentText);

        if (!commentReplies.containsKey(commentText)) {
          commentReplies[commentText] = [];
        }
        textEditingController.clear();
      });
    }
  }

  Future<void> addReply(String currentComment, StateSetter updateState) async {
    String replyText = textEditingController2.text.trim();
    if (replyText.isNotEmpty) {
      updateState(() {
        (commentReplies[currentComment] ??= []).add(replyText);
        textEditingController2.clear();
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
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Comments',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19.sp,
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.3),
                            width: 300.w,
                            height: 1.h,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          ...customCommentMethod(
                              comments,
                              context,
                              textEditingController2,
                              addReply,
                              setState,
                              commentReplies,
                              isReactedOnComment,
                              reactionView),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.kAppBar2Color,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: SizedBox(
                              child: TextField(
                                controller: textEditingController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
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
                                      addComment(setState);
                                    },
                                    icon: const Icon(
                                        FontAwesomeIcons.solidPaperPlane),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
}

Iterable<Widget> customCommentMethod(
    List<String> comments,
    BuildContext context,
    TextEditingController textEditingController2,
    Future<void> Function(String, StateSetter) addReply,
    StateSetter setState,
    Map<String, List<String>> commentReplies,
    bool isCommentReacted,
    bool reactionView) {
  return comments.map((comment) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CustomUserProfileImage(
                          image: '',
                          isActive: true,
                          showname: '',
                        ),
                        SizedBox(width: 15.w),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.kAppBar2Color,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Name'),
                                      Text('1 day ago'),
                                    ],
                                  ),
                                  Text(
                                    comment,
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
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SizedBox(width: 60.w),
                        const InkWell(child: Text('Like')),
                        SizedBox(width: 30.w),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.kAppBar2Color,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: SizedBox(
                                            child: TextField(
                                              controller:
                                                  textEditingController2,
                                              maxLines: null,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Reply to Name comment',
                                                border: OutlineInputBorder(
                                                  gapPadding: 0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  gapPadding: 0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  gapPadding: 0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    addReply(comment, setState);
                                                  },
                                                  icon: const Icon(
                                                      FontAwesomeIcons
                                                          .solidPaperPlane),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const Text('Reply')),
                      ],
                    ),
                    ...commentReplies[comment]
                            ?.map((reply) => commentReplyWidget(
                                reply,
                                context,
                                textEditingController2,
                                setState,
                                addReply,
                                comment))
                            .toList() ??
                        [],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }).toList();
}

Widget commentReplyWidget(
    String reply,
    BuildContext context,
    TextEditingController textEditingController2,
    StateSetter setState,
    Future<void> Function(String, StateSetter) addReply,
    String currentComment) {
  return Padding(
    padding: EdgeInsets.only(top: 10.h),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40.w),
            const CustomUserProfileImage(
              image: '',
              isActive: true,
              showname: '',
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kAppBar2Color,
                  borderRadius: BorderRadius.circular(15.r),
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
                        reply,
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
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              SizedBox(width: 100.w),
              const Text('Like'),
              SizedBox(width: 30.w),
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.kAppBar2Color,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: SizedBox(
                                  child: TextField(
                                    controller: textEditingController2,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Reply to Name comment',
                                      border: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      suffixIcon: SizedBox(
                                        width: 89.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(FontAwesomeIcons
                                                  .solidFaceSmile),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                addReply(
                                                    currentComment, setState);
                                              },
                                              icon: const Icon(FontAwesomeIcons
                                                  .solidPaperPlane),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: const Text('Reply')),
            ],
          ),
        ),
      ],
    ),
  );
}
