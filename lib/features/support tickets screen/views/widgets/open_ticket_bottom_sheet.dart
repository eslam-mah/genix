import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_form.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/post%20ticket/post_ticket_cubit.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> openTicketBottomSheet(
  BuildContext context, {
  required Function() refresh,
  required TicketsModel tickets,
}) {
  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => PostTicketCubit(),
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
                        'Create a new support ticket',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      const Text(
                        'New intervention',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('Intervention title',
                          style: TextStyle(fontSize: 11.sp)),
                      Text(
                          'Feed this intervention with a comprehensive content. please include as many details as you can, in all the possible forms to get a proper resolution.',
                          style: TextStyle(fontSize: 11.sp)),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField2(
                          readOnly: false,
                          hintText: 'Type here the title',
                          controller: titleController,
                          icon: const Text('')),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('Content', style: TextStyle(fontSize: 11.sp)),
                      Text(
                          'Feed this report with a comprehensive content. please include as many details as you can, in all the possible forms to get a proper resolution.',
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
                              controller: contentController,
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
                          buttonText: 'Submit ticket',
                          width: double.infinity,
                          height: 40.h,
                          borderRadius: 12.r,
                          onTap: () {
                            if (tickets.status == 'closed') {
                              context.read<PostTicketCubit>().postTicket(
                                    data: TicketForm(
                                        title: titleController.text.trim(),
                                        content: contentController.text.trim()),
                                  );
                              GoRouter.of(context).pop();
                              refresh();
                            } else if (contentController.text.length < 10) {
                              GoRouter.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'content must not be less than 10 characters',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  backgroundColor:
                                      ThemeCubit().state == ThemeState.dark
                                          ? Colors.white
                                          : Colors.black,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else {
                              GoRouter.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'There is an open intervention, please close it first',
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  backgroundColor:
                                      ThemeCubit().state == ThemeState.dark
                                          ? Colors.white
                                          : Colors.black,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
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
