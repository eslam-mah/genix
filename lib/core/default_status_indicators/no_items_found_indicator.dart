import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../localization/all_app_strings.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  const NoItemsFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(AppStrings.nothingtodisplay.getString(context)
          ,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.sp,
            letterSpacing: 0.3,
          ),
        ),
      );
}
