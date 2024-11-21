import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/followings%20list%20page/view%20model/get%20followings/get_followings_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/get_all_groups/get_all_groups_cubit.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/share_form.dart';
import 'package:genix/features/home%20screen/view%20model/share%20post/share_post_cubit.dart';
import 'package:genix/features/home%20screen/views/widgets/share_post/group_share_item.dart';
import 'package:genix/features/home%20screen/views/widgets/share_post/page_share_item.dart';
import 'package:genix/features/home%20screen/views/widgets/share_post/share_by_widget.dart';
import 'package:genix/features/home%20screen/views/widgets/share_post/user_share_item.dart';
import 'package:genix/features/pages%20screen/view%20model/get_all_pages/get_all_pages_cubit.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> shareBottomSheet(BuildContext context,
    {required PostsModel postModel, required SettingsModel myAccount}) {
  int typeSelected = 0;
  int? selectedFollowingId; // Track selected user ID
  int? selectedGroupId; // Track selected group ID
  int? selectedPageId; // Track selected page ID
  final TextEditingController postController = TextEditingController();

  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    enableDrag: true,
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetFollowingsCubit()
              ..getFollowings(id: myAccount.data?.id ?? 0),
          ),
          BlocProvider(
            create: (context) => GetAllGroupsCubit()..getAllGroups(),
          ),
          BlocProvider(
            create: (context) => GetAllPagesCubit()..getAllPages(),
          ),
          BlocProvider(
            create: (context) => SharePostCubit(),
          ),
        ],
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share this post to',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            ShareByWidget(
                              typeSelected: 1,
                              icon: FontAwesomeIcons.userGroup,
                              text: 'Followings',
                              isSelected: typeSelected,
                              onTap: () => setState(() {
                                typeSelected = typeSelected == 1 ? 0 : 1;
                                context
                                    .read<GetFollowingsCubit>()
                                    .getFollowings(id: myAccount.data?.id ?? 0);
                              }),
                            ),
                            SizedBox(width: 10.w),
                            ShareByWidget(
                              typeSelected: 2,
                              icon: FontAwesomeIcons.diagramProject,
                              text: 'Groups',
                              isSelected: typeSelected,
                              onTap: () => setState(() {
                                typeSelected = typeSelected == 2 ? 0 : 2;
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            ShareByWidget(
                              typeSelected: 3,
                              icon: FontAwesomeIcons.solidFile,
                              text: 'Page',
                              isSelected: typeSelected,
                              onTap: () => setState(() {
                                typeSelected = typeSelected == 3 ? 0 : 3;
                              }),
                            ),
                            SizedBox(width: 10.w),
                            ShareByWidget(
                              typeSelected: 4,
                              icon: FontAwesomeIcons.networkWired,
                              text: 'Timeline',
                              isSelected: typeSelected,
                              onTap: () => setState(() {
                                typeSelected = typeSelected == 4 ? 0 : 4;
                              }),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: typeSelected == 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'SELECT A USER',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              BlocBuilder<GetFollowingsCubit,
                                  GetFollowingsState>(
                                builder: (context, state) {
                                  if (state is GetFollowingsSuccess) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.w,
                                        mainAxisSpacing: 5.h,
                                        childAspectRatio: 3.1,
                                      ),
                                      itemCount: state
                                          .followings.data.collection.length,
                                      itemBuilder: (context, index) {
                                        final user = state
                                            .followings.data.collection[index];
                                        return FollowingsShareItem(
                                          isSelected: selectedFollowingId ==
                                              user.user.id,
                                          user: user,
                                          onTap: () {
                                            setState(() {
                                              selectedFollowingId =
                                                  selectedFollowingId ==
                                                          user.user.id
                                                      ? null
                                                      : user.user.id;
                                            });
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        const CircularProgressIndicator(
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          'Loading List',
                                          style: TextStyle(fontSize: 12.sp),
                                        )
                                      ],
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: typeSelected == 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'SELECT A GROUP',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              BlocBuilder<GetAllGroupsCubit, GetAllGroupsState>(
                                builder: (context, state) {
                                  if (state is GetAllGroupsSuccess) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.w,
                                        mainAxisSpacing: 5.h,
                                        childAspectRatio: 3.1,
                                      ),
                                      itemCount:
                                          state.groups.data.collection.length,
                                      itemBuilder: (context, index) {
                                        final group =
                                            state.groups.data.collection[index];
                                        return GroupShareItem(
                                          isSelected:
                                              selectedGroupId == group.id,
                                          group: group,
                                          onTap: () {
                                            setState(() {
                                              selectedGroupId =
                                                  selectedGroupId == group.id
                                                      ? null
                                                      : group.id;
                                            });
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        const CircularProgressIndicator(
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          'Loading List',
                                          style: TextStyle(fontSize: 12.sp),
                                        )
                                      ],
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: typeSelected == 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'SELECT A PAGE',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              BlocBuilder<GetAllPagesCubit, GetAllPagesState>(
                                builder: (context, state) {
                                  if (state is GetAllPagesSuccess) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.w,
                                        mainAxisSpacing: 5.h,
                                        childAspectRatio: 3.1,
                                      ),
                                      itemCount:
                                          state.pages.data.collection.length,
                                      itemBuilder: (context, index) {
                                        final page =
                                            state.pages.data.collection[index];
                                        return PageShareItem(
                                          isSelected: selectedPageId == page.id,
                                          page: page,
                                          onTap: () {
                                            setState(() {
                                              selectedPageId =
                                                  selectedPageId == page.id
                                                      ? null
                                                      : page.id;
                                            });
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        const CircularProgressIndicator(
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          'Loading List',
                                          style: TextStyle(fontSize: 12.sp),
                                        )
                                      ],
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: typeSelected == 4,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ThemeCubit().state == ThemeState.dark
                                      ? DarkModeColors.kItemColorDark
                                      : AppColors.kTextFieldColor,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                height: 100.h,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    TextField(
                                      expands: true,
                                      maxLines: null,
                                      controller: postController,
                                      decoration: InputDecoration(
                                        hintText: ' Write something...',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.2))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.2))),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 12, 48, 12),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.2))),
                                      ),
                                      textAlignVertical: TextAlignVertical.top,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomButton(
                            color: AppColors.kPrimaryColor,
                            buttonText: 'Share now',
                            width: double.infinity,
                            height: 40.h,
                            borderRadius: 12.r,
                            onTap: () {
                              String shareType() {
                                switch (typeSelected) {
                                  case 1:
                                    return 'following';
                                  case 2:
                                    return 'groups';
                                  case 3:
                                    return 'pages';
                                  case 4:
                                    return 'timeline';
                                  default:
                                    return 'timeline';
                                }
                              }

                              // Creating ShareForm with non-null, non-empty fields
                              final shareData = ShareForm(
                                type: shareType(),
                                content: postController.text.trim().isNotEmpty
                                    ? postController.text.trim()
                                    : null,
                                userId: selectedFollowingId?.toString(),
                                groupId: selectedGroupId?.toString(),
                                pageId: selectedPageId?.toString(),
                              );

                              // Call sharePost if at least one field is not null
                              if (shareData.userId != null ||
                                  shareData.groupId != null ||
                                  shareData.pageId != null ||
                                  shareData.content != null) {
                                context.read<SharePostCubit>().sharePost(
                                    data: shareData,
                                    postId: postModel.id?.toInt() ?? 0);
                                GoRouter.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "Post Shared Successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "You must select at least one field",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0);
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
