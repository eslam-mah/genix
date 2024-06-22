import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/home%20screen/views/widgets/promote_bottom_sheet.dart';
import 'package:genix/features/home%20screen/views/widgets/show_report_bottom_sheet.dart';

Future<dynamic> showPostTabBar(BuildContext context, bool isNightModeEnabled) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 149.h,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    title: Text('View post'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    promoteBottomSheet(context);
                  },
                  child: const ListTile(
                    title: Text('Promote'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    reportBottomSheet(context, isNightModeEnabled);
                  },
                  child: const ListTile(
                    title: Text('Report'),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
