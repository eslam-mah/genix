import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';

class CustomAddButton extends StatelessWidget {
  const CustomAddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.transparent, shape: BoxShape.circle),
          width: 45.r,
          height: 45.r,
        ),
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            top: 0,
            child: CircleAvatar(
              backgroundColor: ThemeCubit().state == ThemeState.dark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.white,
              radius: 10.r,
            )),
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            top: 0,
            child: Icon(
              FontAwesomeIcons.plus,
              size: 15.r,
              color: AppColors.kPrimaryColor2,
            ))
      ],
    );
  }
}
