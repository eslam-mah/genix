import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextwidget.dart';

import 'package:genix/features/home%20screen/views/widgets/show_report_bottom_sheet.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page/delete_page_cubit.dart';
import 'package:genix/features/pages%20screen/views/screens/page_followers_screen.dart';
import 'package:genix/features/pages%20screen/views/screens/pages_list_body.dart';
import 'package:genix/features/pages%20screen/views/widgets/create_page/edit_page_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> showPageTabBar(
  BuildContext context,
  PageProfileModel pageModel,
  Function() refresh,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content: SizedBox(
              height: pageModel.data!.page!.me!.manager! ? 180.h : 45.h,
              child: Column(
                children: [
                  if (pageModel.data!.page!.me!.manager!) ...[
                    InkWell(
                      onTap: () {
                        editPageBottomSheet(
                            context, refresh, pageModel.data?.page?.id ?? 0);
                      },
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: 'Edit page'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => DeletePageCubit(),
                                child: _DeletePageDialog(pageModel),
                              );
                            });
                      },
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: 'Delete page'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context)
                            .push(PageFollowersScreen.route, extra: pageModel);
                      },
                      child: ListTile(
                        title: CustomTextWidget(
                            textSize: 15.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.normal,
                            text: 'page members'),
                      ),
                    ),
                  ],
                  InkWell(
                    onTap: () {
                      reportBottomSheet(
                        context,
                        pageProfileModel: pageModel,
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
                ],
              ),
            ),
          );
        });
      });
}

class _DeletePageDialog extends StatelessWidget {
  final PageProfileModel pageModel;
  const _DeletePageDialog(this.pageModel);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocBuilder<DeletePageCubit, DeletePageState>(
        builder: (context, state) {
          if (state is DeletePageLoading) {
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
                    'Are you sure you want to Delete this page?',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: 'Yes',
                          height: 30.h,
                          borderRadius: 30.r,
                          width: 80.w,
                          onTap: () async {
                            context
                                .read<DeletePageCubit>()
                                .deletePage(id: pageModel.data?.page?.id ?? 0);

                            // ignore: use_build_context_synchronously
                            GoRouter.of(context).push(PagesListBody.route);
                          }),
                      CustomButton(
                          color: Colors.red,
                          buttonText: 'no',
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
