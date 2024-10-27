import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatelessWidget {
  final Function() refresh;
  final Function() request;
  final String functionName;
  const ConfirmationDialog(
      {required this.refresh,
      required this.request,
      required this.functionName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SizedBox(
      height: 100.h,
      width: 300.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Are you sure you want to $functionName',
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
                    await request();
                    // Close dialog and refresh the parent view
                    // ignore: use_build_context_synchronously

                    GoRouter.of(context).pop();
                    refresh();
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
    ));
  }
}
