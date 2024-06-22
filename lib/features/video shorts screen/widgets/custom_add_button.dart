import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

class CustomAddButton extends StatelessWidget {
  const CustomAddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.kPrimaryColor2,
          radius: 22.r,
        ),
        Positioned(
            left: 2,
            bottom: 2,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.r,
            )),
        Positioned(
            left: 16,
            bottom: 15,
            child: Icon(
              FontAwesomeIcons.plus,
              size: 15.r,
              color: AppColors.kPrimaryColor2,
            ))
      ],
    );
  }
}
