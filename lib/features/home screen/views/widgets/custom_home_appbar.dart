import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:genix/core/utils/images.dart';
import 'package:genix/features/home%20screen/views/widgets/add%20post%20bottom%20sheet/addpostbottomsheet.dart';
import 'package:genix/core/widgets/customappbaricon.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/search%20page/views/view/search_page.dart';
import 'package:go_router/go_router.dart';

class CustomHomeAppBar extends StatelessWidget {
  final Function() refresh;
  const CustomHomeAppBar({
    super.key,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomAppBarIcon(
          icon: FontAwesomeIcons.chevronLeft,
          onTap: () {},
          size: 18.sp,
        ),
        CustomAppBarIcon(
          icon: FontAwesomeIcons.magnifyingGlass,
          onTap: () {
            GoRouter.of(context).push(SearchPage.route);
          },
          size: 18.sp,
        ),
        Image.asset(
          AppImages.kLogo,
          width: 37.w,
        ),
        CustomAppBarIcon(
          icon: Icons.post_add_outlined,
          onTap: () async {
            await addPostModalBottomSheet(context, refresh);
          },
          size: 25.sp,
        )
      ],
    );
  }
}
