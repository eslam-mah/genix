import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  const NoItemsFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          "Nothing to display...",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.sp,
            letterSpacing: 0.3,
          ),
        ),
      );
}
