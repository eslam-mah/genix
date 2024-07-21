import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          "noData",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.sp,
            letterSpacing: 0.3,
          ),
        ),
      );
  /* const FirstPageExceptionIndicator(
        title: 'No items found',
        message: 'The list is currently empty.',
      );*/
}
