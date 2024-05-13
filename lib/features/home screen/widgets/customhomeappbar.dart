import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/addpostbottomsheet.dart';
import 'package:genix/core/widgets/customappbaricon.dart';

import 'package:go_router/go_router.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomAppBarIcon(
          icon: FontAwesomeIcons.chevronLeft,
          color: Colors.black,
          onTap: () {},
          size: 18.sp,
        ),
        CustomAppBarIcon(
          icon: FontAwesomeIcons.magnifyingGlass,
          color: Colors.black,
          onTap: () {},
          size: 18.sp,
        ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pushReplacement(Rout.kHome);
          },
          child: Image.asset(
            AppImages.kLogo,
            width: 37.w,
          ),
        ),
        CustomAppBarIcon(
          icon: Icons.post_add_outlined,
          color: Colors.black,
          onTap: () async {
            await addPostModalBottomSheet(context);
          },
          size: 25.sp,
        )
      ],
    );
  }
}
