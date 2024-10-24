import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group_member_post/delete_group_member_post_cubit.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/view%20model/delete%20post/delete_post_cubit.dart';
import 'package:genix/features/home%20screen/views/widgets/promote_bottom_sheet.dart';
import 'package:genix/features/home%20screen/views/widgets/show_report_bottom_sheet.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member_post/delete_page_member_post_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

Future<dynamic> showPostTabBar(
    BuildContext context,
    int id,
    PostsModel postsModel,
    Function() refresh,
    PagingController<int, PostsModel> pagingController) {
  return showDialog(
      context: context,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => DeletePostCubit(),
            ),
          ],
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: SizedBox(
                height: postsModel.user?.id == id ? 180.h : 132.h,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: 'View post'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        promoteBottomSheet(context);
                      },
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: 'Promote'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        reportBottomSheet(
                          context,
                          postModel: postsModel,
                        );
                      },
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: 'Report'),
                      ),
                    ),
                    if (postsModel.user?.id == id) ...[
                      // InkWell(
                      //   onTap: () {
                      //     reportBottomSheet(context, postsModel);
                      //   },
                      //   child: ListTile(
                      //     title: CustomTextWidget(
                      //       textSize: 15.sp,
                      //       fontFamily: '',
                      //       fontWeight: FontWeight.normal,
                      //       text: 'Edit',
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          context
                              .read<DeletePostCubit>()
                              .deletePost(postId: postsModel.id!.toInt());

                          /// delete post
                          final updatedPosts = pagingController.itemList
                              ?.where((post) => post.id != postsModel.id)
                              .toList();
                          if (updatedPosts != null) {
                            pagingController.itemList = updatedPosts;
                          }
                          GoRouter.of(context).pop();
                        },
                        child: ListTile(
                          title: CustomTextWidget(
                              textSize: 15.sp,
                              fontFamily: '',
                              fontWeight: FontWeight.normal,
                              text: 'Delete'),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          }),
        );
      });
}
