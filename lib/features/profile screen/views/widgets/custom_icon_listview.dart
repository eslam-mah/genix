import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/features/followers%20list%20page/views/view/my_followers_page.dart';
import 'package:genix/features/followings%20list%20page/views/view/followings_page.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_icon_profile_button.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/all_app_strings.dart';

class CustomIconButtonListView extends StatelessWidget {
  const CustomIconButtonListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CustomIconProfileButton(
            icon: FontAwesomeIcons.solidUser,
            text:  AppStrings.about.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.keyboard,
            text:  AppStrings.timeline.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.users,
            text:  AppStrings.followers.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.userPlus,
            text:  AppStrings.followings.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.userSlash,
            text:  AppStrings.blocked.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.prescription,
            text:  AppStrings.restricted.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.image,
            text:  AppStrings.photos.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.video,
            text:  AppStrings.video.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.solidCirclePlay,
            text:  AppStrings.short.getString(context),
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.solidBookmark,
            text:  AppStrings.saved.getString(context),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
