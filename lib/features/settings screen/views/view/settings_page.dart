import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customappbar.dart';

import 'package:genix/core/widgets/custombottomappbar.dart';

import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';

import 'package:genix/core/widgets/glowingbuttonbody.dart';
import 'package:genix/features/settings%20screen/views/view/billing_setting_view.dart';
import 'package:genix/features/settings%20screen/views/view/emails_setting_view.dart';

import 'package:genix/features/settings%20screen/views/view/general_settings_view.dart';
import 'package:genix/features/settings%20screen/views/view/profile_settings_view.dart';
import 'package:genix/features/settings%20screen/views/view/security_setting_view.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  static const route = '/settings';
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          CustomBottomAppBar(
            isNightMode: isNightModeEnabled,
          ),
          Positioned(
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                child: CustomGlowingButton(isSelected: isSelected),
              ))
        ],
      )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.barsStaggered,
              size: 18.sp,
            ), // Custom icon
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // Open the drawer
            },
          ),
        ],
        elevation: 0,
        title: const CustomAppBar(),
      ),
      endDrawer: CustomDrawerWidget(
        isNightMode: isNightModeEnabled,
      ),
      body: isSelected
          ? const GlowingButtonBody()
          : DefaultTabController(
              length: 5,
              child: Scaffold(
                body: Column(
                  children: [
                    const CustomHeaderWidget(text: 'Settings'),
                    const TabBar(
                      labelColor: Colors.green,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: 'General',
                        ),
                        Tab(text: 'Profile'),
                        Tab(text: 'Security'),
                        Tab(text: 'Emails'),
                        Tab(text: 'Billing'),
                      ],
                      indicatorColor: Colors.green,
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        GeneralSettingsBody(
                          isNightModeEnabled: isNightModeEnabled,
                        ),
                        ProfileSettingsBody(
                            isNightModeEnabled: isNightModeEnabled),
                        SecuritySettingsBody(
                            isNightModeEnabled: isNightModeEnabled),
                        EmailsSettingBody(
                            isNightModeEnabled: isNightModeEnabled),
                        BillingAreaSettings(
                          isNightModeEnabled: isNightModeEnabled,
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
