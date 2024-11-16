import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/group_profile_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/report_form.dart';
import 'package:genix/features/home%20screen/view%20model/post%20report/post_report_cubit.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/page_profile_model.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/all_app_strings.dart';

Future<dynamic> reportBottomSheet(
  BuildContext context, {
  PostsModel? postModel,
  GroupProfileModel? groupProfileModel,
  PageProfileModel? pageProfileModel,
}) {
  TextEditingController reportController = TextEditingController();

  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => PostReportCubit(),
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
                        '${AppStrings.submitanewpost.getString(context)}',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                       Text(
                        '${AppStrings.replypost.getString(context)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('${AppStrings.content.getString(context)}', style: TextStyle(fontSize: 11.sp)),
                      Text(
                          '${AppStrings.submitanewpostdescription.getString(context)}',
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
                              controller: reportController,
                              expands: true,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText:'${AppStrings.writesomething.getString(context)}',
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
                          buttonText: '${AppStrings.reportnow.getString(context)}',
                          width: double.infinity,
                          height: 40.h,
                          borderRadius: 12.r,
                          onTap: () {
                            context.read<PostReportCubit>().postReport(
                                data: ReportForm(
                                    content: reportController.text.trim(),
                                    postId: postModel?.id.toString(),
                                    groupId: postModel?.group?.id != null
                                        ? postModel?.group?.id.toString()
                                        : '',
                                    pageId: postModel?.page?.id != null
                                        ? postModel?.page?.id.toString()
                                        : '',
                                    profileId: postModel?.user?.id != null
                                        ? postModel?.user?.id.toString()
                                        : ''));
                            GoRouter.of(context).pop();
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
