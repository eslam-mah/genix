import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/widgets/customappbar.dart';

import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';

import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';

import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/notifications%20screen/views/widgets/notification_shimmer_item.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/views/view/billing_setting_view.dart';
import 'package:genix/features/settings%20screen/views/view/emails_setting_view.dart';

import 'package:genix/features/settings%20screen/views/view/general_settings_view.dart';
import 'package:genix/features/settings%20screen/views/view/profile_settings_view.dart';
import 'package:genix/features/settings%20screen/views/view/security_setting_view.dart';
import 'package:genix/features/settings%20screen/views/widgets/settings_shimmer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.initialIndex});
  static const route = '/settings';
  final int initialIndex;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;
  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;
    context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ThemeCubit, ThemeState>(
          listener: (context, state) {
            final isNightMode = state == ThemeState.dark;
            handleNightModeChanged(isNightMode);
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: SafeArea(
            child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const CustomBottomAppBar(),
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
          toolbarHeight: 45.h,
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
                initialIndex: widget.initialIndex,
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
                      BlocBuilder<GetMyAccountDetailsCubit,
                          GetMyAccountDetailsState>(
                        builder: (context, state) {
                          if (state is GetMyAccountDetailsSuccess) {
                            return Expanded(
                              child: TabBarView(children: [
                                GeneralSettingsBody(
                                  setting: state.account,
                                ),
                                ProfileSettingsBody(
                                  setting: state.account,
                                ),
                                SecuritySettingsBody(
                                  setting: state.account,
                                ),
                                EmailsSettingBody(
                                  setting: state.account,
                                ),
                                const BillingAreaSettings()
                              ]),
                            );
                          } else {
                            print('____________________________${state}');
                            return SettingsShimmer(
                                isNightModeEnabled: isNightModeEnabled);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
