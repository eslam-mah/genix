import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/addpostbottomsheet.dart';
import 'package:genix/core/widgets/customappbaricon.dart';
import 'package:genix/features/home%20screen/views/view/homebody.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
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
          onTap: () {
            GoRouter.of(context).pop();
          },
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
            GoRouter.of(context).pushReplacement(HomePage.routeName);
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
            // await addPostModalBottomSheet(context);
          },
          size: 25.sp,
        )
      ],
    );
  }
}
