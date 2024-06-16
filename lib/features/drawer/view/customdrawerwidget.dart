import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/customlisttile.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:go_router/go_router.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({
    super.key,
    required this.onNightModeChanged,
    required this.isNightMode,
  });
  final Function(bool) onNightModeChanged;
  final bool isNightMode;
  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  bool isNightMode = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            width: 240,
            child: Drawer(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CustomUserProfileImage(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Radu',
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 4,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text(
                                'Active',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        width: 40.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.kPrimaryColor2),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomListTile(
                    icon: FontAwesomeIcons.gear,
                    text: 'Settings',
                    onTap: () {
                      GoRouter.of(context).push(Rout.kSettingsScreen);
                    },
                  ),
                  CustomListTile(
                    icon: FontAwesomeIcons.coins,
                    text: 'Get coins',
                    onTap: () {},
                  ),
                  CustomListTile(
                    icon: FontAwesomeIcons.fileShield,
                    text: 'Help & FAQ',
                    onTap: () {},
                  ),
                  CustomListTile(
                    icon: FontAwesomeIcons.arrowUp,
                    text: 'Promotions',
                    onTap: () {},
                  ),
                  CustomListTile(
                    icon: FontAwesomeIcons.key,
                    text: 'Lock screen',
                    onTap: () {},
                  ),
                  CustomListTile(
                    icon: FontAwesomeIcons.rightFromBracket,
                    text: 'Logout',
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesomeIcons.solidMoon,
                        size: 20.sp,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      Text(
                        'Dark mode',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                      Switch(
                        value: widget.isNightMode,
                        onChanged: (value) {
                          setState(() {
                            isNightMode = value;
                            widget.onNightModeChanged(value);
                            CacheData.setData(
                                key: PrefKeys.kDarkMode, value: value);
                          });
                        },
                        activeTrackColor: AppColors.kPrimaryColor2,
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
