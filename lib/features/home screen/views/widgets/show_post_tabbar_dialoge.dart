import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/promote_bottom_sheet.dart';
import 'package:genix/features/home%20screen/views/widgets/show_report_bottom_sheet.dart';

Future<dynamic> showPostTabBar(BuildContext context, bool isNightModeEnabled,
    int id, PostsModel postsModel) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: postsModel.user?.id == id ? 220.h : 132.h,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: CustomTextWidget(
                        textSize: 15.sp,
                        fontFamily: '',
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
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
                        color: Colors.black,
                        text: 'Promote'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    reportBottomSheet(context, isNightModeEnabled);
                  },
                  child: ListTile(
                    title: CustomTextWidget(
                        textSize: 15.sp,
                        fontFamily: '',
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        text: 'Report'),
                  ),
                ),
                if (postsModel.user?.id == id) ...[
                  InkWell(
                    onTap: () {
                      reportBottomSheet(context, isNightModeEnabled);
                    },
                    child: ListTile(
                      title: CustomTextWidget(
                          textSize: 15.sp,
                          fontFamily: '',
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          text: 'Edit'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      reportBottomSheet(context, isNightModeEnabled);
                    },
                    child: ListTile(
                      title: CustomTextWidget(
                          textSize: 15.sp,
                          fontFamily: '',
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          text: 'Delete'),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      });
}
