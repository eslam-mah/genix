import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/custombutton.dart';

import 'package:genix/features/home%20screen/view%20model/post%20report/post_report_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_comment_form.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/post%20ticket%20comment/post_ticket_comment_cubit.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> postReplyBottomSheet(
    BuildContext context, Function() refresh, int id) {
  TextEditingController replyController = TextEditingController();

  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => PostTicketCommentCubit(),
          child: StatefulBuilder(builder: (
            BuildContext context,
            StateSetter setState,
          ) {
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add new comment',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      const Text(
                        'Post a reply',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('Content', style: TextStyle(fontSize: 11.sp)),
                      Text(
                          'Feed this reply with a comprehensive content. please include as many details as you can, in all the possible forms to get a proper resolution.',
                          style: TextStyle(fontSize: 11.sp)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        height: 120.h,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            TextField(
                              controller: replyController,
                              expands: true,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: ' Write something...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.kPrimaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.kPrimaryColor)),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(12, 12, 48, 12),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.kPrimaryColor)),
                              ),
                              textAlignVertical: TextAlignVertical.top,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: 'Submit Comment',
                          width: double.infinity,
                          height: 40.h,
                          borderRadius: 12.r,
                          onTap: () {
                            context
                                .read<PostTicketCommentCubit>()
                                .postTicketComment(
                                    data: TicketCommentForm(
                                        content: replyController.text.trim()),
                                    id: id)
                                .then((onValue) {
                              GoRouter.of(context).pop();
                            });
                            refresh();
                          }),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  )),
            ));
          }),
        );
      });
}