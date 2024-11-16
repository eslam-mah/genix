import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/member.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/view%20model/get_page_members/get_page_members_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/update_page_member/update_page_member_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/all_app_strings.dart';

Future<dynamic> followerRolesBottomSheet(
    BuildContext context,
    final PageProfileModel pageProfileModel,
    final Member member,
    final Function() refresh // Member's current data
    ) {
  // Local state for selected role and permissions
  String selectedRole =
      member.roles?.isNotEmpty == true ? member.roles!.first : 'None';
  List<String> selectedPermissions =
      List<String>.from(member.permissions ?? []);

  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    enableDrag: true,
    context: context,
    builder: (context) {
      bool isLoading = false;
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UpdatePageMemberCubit(),
          ),
          BlocProvider(
            create: (context) => GetPageMembersCubit()
              ..getPageMembers(
                  id: pageProfileModel.data?.page?.id ?? 0, page: 1),
          ),
        ],
        child: StatefulBuilder(builder: (
          BuildContext context,
          StateSetter setState,
        ) {
          return BlocBuilder<GetPageMembersCubit, GetPageMembersState>(
            builder: (context, state) {
              if (state is GetPageMembersSuccess) {
                return Stack(
                  children: [
                    SingleChildScrollView(
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
                                '${AppStrings.editmemberdetails.getString(context)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23.sp),
                              ),
                              SizedBox(height: 20.h),
                              Text('${AppStrings.availableroles.getString(context)}',
                                  style: TextStyle(fontSize: 16.sp)),
                              SizedBox(height: 15.h),

                              _RadioButtonRow(
                                title:'${AppStrings.pagemanger.getString(context)}',
                                value: 'page manager',
                                pageValue: selectedRole,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedRole = value!;
                                  });
                                },
                                description:
                                '${AppStrings.pagemangerdescription.getString(context)}'  ),
                              SizedBox(height: 20.h),

                              _RadioButtonRow(
                                title: '${AppStrings.pagemoderatord.getString(context)}',
                                value: 'page moderator',
                                pageValue: selectedRole,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedRole = value!;
                                  });
                                },
                                description:'${AppStrings.pagemoderatorddescription.getString(context)}',
                              ),
                              SizedBox(height: 20.h),

                              // Radio Button for None (no role)
                              _RadioButtonRow(
                                title: '${AppStrings.none.getString(context)}',
                                value: 'None',
                                pageValue: selectedRole,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedRole = value!;
                                  });
                                },
                                description: '',
                              ),
                              SizedBox(height: 20.h),

                              Text('${AppStrings.availablepermission.getString(context)}',
                                  style: TextStyle(fontSize: 16.sp)),
                              SizedBox(height: 15.h),

                              // Checkboxes for Permissions
                              _CheckboxRow(
                                title: '${AppStrings.alterpagedetails.getString(context)}',
                                value: 'alter page details',
                                selectedPermissions: selectedPermissions,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedPermissions
                                          .add('alter page details');
                                    } else {
                                      selectedPermissions
                                          .remove('alter page details');
                                    }
                                  });
                                },
                              ),
                              SizedBox(height: 10.h),

                              _CheckboxRow(
                                title: '${AppStrings.alterpagemembers.getString(context)}',
                                value: 'alter page members',
                                selectedPermissions: selectedPermissions,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedPermissions
                                          .add('alter page members');
                                    } else {
                                      selectedPermissions
                                          .remove('alter page members');
                                    }
                                  });
                                },
                              ),
                              SizedBox(height: 10.h),

                              _CheckboxRow(
                                title: '${AppStrings.alterpageposts.getString(context)}',
                                value: 'alter page posts',
                                selectedPermissions: selectedPermissions,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedPermissions
                                          .add('alter page posts');
                                    } else {
                                      selectedPermissions
                                          .remove('alter page posts');
                                    }
                                  });
                                },
                              ),
                              SizedBox(height: 10.h),

                              _CheckboxRow(
                                title: '${AppStrings.alterpagepostscomments.getString(context)}',
                                value: 'alter page posts comments',
                                selectedPermissions: selectedPermissions,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedPermissions
                                          .add('alter page posts comments');
                                    } else {
                                      selectedPermissions
                                          .remove('alter page posts comments');
                                    }
                                  });
                                },
                              ),

                              SizedBox(height: 20.h),
                              CustomButton(
                                color: AppColors.kPrimaryColor,
                                buttonText: '${AppStrings.updateuser.getString(context)}',
                                width: double.infinity,
                                height: 40.h,
                                borderRadius: 12.r,
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  // Prepare the selected role
                                  List<String> selectedRoles = [];
                                  if (selectedRole != 'None') {
                                    selectedRoles.add(
                                        selectedRole); // Add the selected role from radio buttons
                                  }

                                  // Prepare the selected permissions from the checkboxes
                                  List<String> selectedPerms = [];
                                  if (selectedPermissions
                                      .contains('alter page details')) {
                                    selectedPerms.add('alter page details');
                                  }
                                  if (selectedPermissions
                                      .contains('alter page members')) {
                                    selectedPerms.add('alter page members');
                                  }
                                  if (selectedPermissions
                                      .contains('alter page posts')) {
                                    selectedPerms.add('alter page posts');
                                  }
                                  if (selectedPermissions
                                      .contains('alter page posts comments')) {
                                    selectedPerms
                                        .add('alter page posts comments');
                                  }

                                  // Call the Cubit to update the member with selected role and permissions
                                  context
                                      .read<UpdatePageMemberCubit>()
                                      .updatePageMember(
                                    updatePageMemberForm: {
                                      'roles': selectedRoles.isEmpty
                                          ? ['none']
                                          : selectedRoles, // Send selected role or 'none'
                                      'permissions':
                                          selectedPerms, // Send selected permissions
                                    },
                                    memberId: member.id ??
                                        0, // The member ID you are updating
                                  );
                                  setState(() {
                                    isLoading = true;
                                  });
                                  GoRouter.of(context).pop();
                                  refresh();
                                },
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                );
              }
            },
          );
        }),
      );
    },
  );
}

class _CheckboxRow extends StatelessWidget {
  final String title;
  final String value;
  final List<String> selectedPermissions;
  final Function(bool) onChanged;

  const _CheckboxRow({
    super.key,
    required this.title,
    required this.value,
    required this.selectedPermissions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 15.w),
        Checkbox(
          value: selectedPermissions.contains(value),
          onChanged: (bool? isChecked) {
            onChanged(isChecked ?? false);
          },
          focusColor: AppColors.kPrimaryColor,
          activeColor: AppColors.kPrimaryColor,
        ),
        Expanded(
          child: CustomTextWidget(
            textSize: 16.sp,
            fontFamily: '',
            fontWeight: FontWeight.normal,
            text: title,
          ),
        ),
      ],
    );
  }
}

class _RadioButtonRow extends StatelessWidget {
  final String title;
  final String value;
  final String pageValue;
  final String description;
  final Function(String?)? onChanged;

  const _RadioButtonRow({
    super.key,
    required this.title,
    required this.value,
    required this.pageValue,
    required this.onChanged,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15.w),
          Radio<String>(
            value: value,
            groupValue: pageValue,
            onChanged: onChanged,
            focusColor: AppColors.kPrimaryColor,
            activeColor: AppColors.kPrimaryColor,
          ),
          SizedBox(
            width: 270.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                  textSize: 16.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.normal,
                  text: title,
                ),
                if (description != '')
                  CustomTextWidget(
                    textSize: 12.sp,
                    fontFamily: '',
                    fontWeight: FontWeight.normal,
                    text: description,
                    maxLines: 3,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
