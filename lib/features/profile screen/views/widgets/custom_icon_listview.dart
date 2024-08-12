import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_icon_profile_button.dart';

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
            text: 'About',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.keyboard,
            text: 'Timeline',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.users,
            text: 'Followers',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.userPlus,
            text: 'Following',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.userSlash,
            text: 'Blocked',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.prescription,
            text: 'Restricted',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.image,
            text: 'Photos',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.video,
            text: 'Video',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.solidCirclePlay,
            text: 'Shorts',
            onTap: () {},
          ),
          CustomIconProfileButton(
            icon: FontAwesomeIcons.solidBookmark,
            text: 'Saved',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
