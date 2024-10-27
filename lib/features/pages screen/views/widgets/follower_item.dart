import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/confirmation_dialoge.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/member.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member/delete_page_member_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member_comment/delete_page_member_comment_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member_post/delete_page_member_post_cubit.dart';
import 'package:genix/features/pages%20screen/views/widgets/follower_roles_bottom_sheet.dart';

import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';

class FollowerItem extends StatelessWidget {
  final Member user;
  final PageProfileModel pageProfileModel;
  final Function() refresh;
  const FollowerItem({
    super.key,
    required this.user,
    required this.pageProfileModel,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
        color: ThemeCubit().state == ThemeState.dark
            ? DarkModeColors.kItemColorDark
            : AppColors.kPostColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            SizedBox(
              width: 12.w,
            ),
            InkWell(
              onTap: () {
                GoRouter.of(context)
                    .push(ProfilePage.route, extra: user.user?.username);
              },
              child: Column(
                children: [
                  CustomUserProfileImage(
                    image: user.user?.profileImg ?? '',
                    showname: user.user?.showname ?? '',
                    isActive: user.user?.isActive ?? false,
                    width: 40.w,
                    height: 40.w,
                    bottom: 15.w,
                    right: 25.w,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 70.w,
                        child: Center(
                          child: Text(
                            user.user?.showname ?? '',
                            style: TextStyle(fontSize: 15.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (user.user?.isVerified ?? false) ...[
                        SizedBox(
                          width: 7.w,
                        ),
                        Icon(
                          Icons.verified,
                          color: AppColors.kPrimaryColor,
                          size: 16.sp,
                        )
                      ]
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        DeletePageMemberPostCubit(),
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                      return ConfirmationDialog(
                                        refresh: refresh,
                                        request: () {
                                          context
                                              .read<DeletePageMemberPostCubit>()
                                              .deletePageMemberPost(
                                                  id: user.id ?? 0);
                                        },
                                        functionName:
                                            'delete all the user\'s posts',
                                      );
                                    }),
                                  );
                                });
                          },
                          style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.all(
                                  AppColors.kPrimaryColor)),
                          child: Text(
                            'Delete posts',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        DeletePageMemberCommentCubit(),
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                      return ConfirmationDialog(
                                        refresh: refresh,
                                        request: () {
                                          context
                                              .read<
                                                  DeletePageMemberCommentCubit>()
                                              .deletePageMemberComment(
                                                  id: user.id ?? 0);
                                        },
                                        functionName:
                                            'delete all the user\'s comments',
                                      );
                                    }),
                                  );
                                });
                          },
                          style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.all(
                                  AppColors.kPrimaryColor)),
                          child: Text(
                            'Delete comments',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        )
                      ],
                    ),
                    if (pageProfileModel.data?.page?.me?.member?.id != user.id)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              followerRolesBottomSheet(
                                  context, pageProfileModel, user, refresh);
                            },
                            style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    AppColors.kPrimaryColor)),
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
                                      create: (context) =>
                                          DeletePageMemberCubit(),
                                      child: StatefulBuilder(
                                          builder: (context, setState) {
                                        return ConfirmationDialog(
                                          refresh: refresh,
                                          request: () {
                                            context
                                                .read<DeletePageMemberCubit>()
                                                .deletePageMember(
                                                    id: user.id ?? 0);
                                          },
                                          functionName: 'remove this user',
                                        );
                                      }),
                                    );
                                  });
                            },
                            style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    AppColors.kPrimaryColor)),
                            child: Text(
                              'Delete',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
