import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/home%20screen/widgets/promotebottomsheet.dart';
import 'package:genix/features/home%20screen/widgets/showreportbottomsheet.dart';

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
