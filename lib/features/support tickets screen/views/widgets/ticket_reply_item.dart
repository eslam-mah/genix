import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/confirmation_dialoge.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_model.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/delete%20ticket%20comment/delete_ticket_comment_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/update%20ticket%20comment/update_ticket_comment_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/edit_ticket_reply_bottom_sheet.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class ReplyItem extends StatelessWidget {
  const ReplyItem({
    super.key,
    required this.comment,
    required this.refresh,
  });

  final Comment comment;
  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    String removeHtmlTags(String htmlString) {
      final document = parse(htmlString);
      return document.body?.text ?? '';
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteTicketCommentCubit, DeleteTicketCommentState>(
          listener: (context, state) {
            if (state is DeleteTicketCommentSuccess) {
              Navigator.of(context).pop();
              refresh();
            }
          },
        ),
        BlocListener<UpdateTicketCommentCubit, UpdateTicketCommentState>(
          listener: (context, state) {
            if (state is UpdateTicketCommentSuccess) {
              Navigator.of(context).pop();
              refresh();
            }
          },
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomUserProfileImage(
                        showname: comment.user?.showname ?? '',
                        image: comment.user?.profileImg ?? '',
                        isActive: comment.user?.isActive ?? false,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            textSize: 13.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            color: Colors.green,
                            text: comment.user?.showname ?? '',
                          ),
                          CustomTextWidget(
                            textSize: 13.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text:
                                'wrote on //${DateFormat('MMMM d, yyyy').format(comment.createdAt ?? DateTime.now())}',
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomTextWidget(
                    maxLines: 1000,
                    textSize: 13.sp,
                    fontFamily: '',
                    fontWeight: FontWeight.normal,
                    text: removeHtmlTags(comment.content ?? ""),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      editTicketReplyBottomSheet(
                        context,
                        refresh,
                        comment.id ?? 0,
                        comment,
                      );
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => DeleteTicketCommentCubit(),
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return ConfirmationDialog(
                                refresh: refresh,
                                request: () => context
                                    .read<DeleteTicketCommentCubit>()
                                    .deleteTicketComment(id: comment.id ?? 0),
                                functionName:
                                    'delete ${comment.user?.showname} comment',
                              );
                            }),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
