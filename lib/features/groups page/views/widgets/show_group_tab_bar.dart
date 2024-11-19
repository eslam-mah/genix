import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/group_profile_model.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group/delete_group_cubit.dart';
import 'package:genix/features/groups%20page/views/screens/group_members_screen.dart';
import 'package:genix/features/groups%20page/views/screens/groups_list_body.dart';
import 'package:genix/features/groups%20page/views/widgets/create_group/edit_group_bottom_sheet.dart';

import 'package:genix/features/home%20screen/views/widgets/show_report_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/all_app_strings.dart';

Future<dynamic> showGroupTabBar(
  BuildContext context,
  GroupProfileModel groupModel,
  Function() refresh,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content: SizedBox(
              height: groupModel.data!.group!.me!.manager! ? 180.h : 45.h,
              child: Column(
                children: [
                  if (groupModel.data!.group!.me!.manager!) ...[
                    InkWell(
                      onTap: () {
                        editGroupBottomSheet(
                            context, refresh, groupModel.data?.group?.id ?? 0);
                      },
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: '${AppStrings.editgroup.getString(context)}'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => DeleteGroupCubit(),
                                child: _DeleteGroupDialog(groupModel),
                              );
                            });
                      },
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: '${AppStrings.deletegroup.getString(context)}'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context)
                            .push(GroupMembersScreen.route, extra: groupModel);
                      },
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: '${AppStrings.groupmembers.getString(context)}'),
                      ),
                    ),
                  ],
                  InkWell(
                    onTap: () {
                      reportBottomSheet(
                        context,
                        groupProfileModel: groupModel,
                      );
                    },
                    child: ListTile(
                      title: CustomTextWidget(
                          textSize: 15.sp,
                          fontFamily: '',
                          fontWeight: FontWeight.normal,
                          text: '${AppStrings.report.getString(context)}'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}

class _DeleteGroupDialog extends StatelessWidget {
  final GroupProfileModel groupModel;
  const _DeleteGroupDialog(this.groupModel);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocBuilder<DeleteGroupCubit, DeleteGroupState>(
        builder: (context, state) {
          if (state is DeleteGroupLoading) {
            return SizedBox(
              height: 100.h,
              width: 300.w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            );
          } else {
            return SizedBox(
              height: 100.h,
              width: 300.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${AppStrings.areyousureyouwanttodeletegroup.getString(context)}',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: '${AppStrings.yes.getString(context)}',
                          height: 30.h,
                          borderRadius: 30.r,
                          width: 80.w,
                          onTap: () async {
                            context.read<DeleteGroupCubit>().deleteGroup(
                                id: groupModel.data?.group?.id ?? 0);

                            // ignore: use_build_context_synchronously
                            GoRouter.of(context).push(GroupsListBody.route);
                          }),
                      CustomButton(
                          color: Colors.red,
                          buttonText: '${AppStrings.no.getString(context)}',
                          height: 30.h,
                          borderRadius: 30.r,
                          width: 80.w,
                          onTap: () {
                            GoRouter.of(context).pop();
                          })
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
