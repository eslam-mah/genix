import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';

import 'package:genix/core/widgets/glowingbuttonbody.dart';

class TicketsItemPageArgs {
  const TicketsItemPageArgs();
}

class TicketItemPage extends StatefulWidget {
  const TicketItemPage({super.key, required this.args});
  static const route = '/ticketItemPage';
  final TicketsItemPageArgs args;
  @override
  State<TicketItemPage> createState() => _TicketItemPageState();
}

class _TicketItemPageState extends State<TicketItemPage> {
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
      backgroundColor: isSelected ? AppColors.kAppBar2Color : Colors.white,
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
              ),
            ),
          ],
        ),
      ),
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
        backgroundColor: AppColors.kAppBar2Color,
        elevation: 0,
        title: const CustomAppBar(),
      ),
      endDrawer: CustomDrawerWidget(
        onNightModeChanged: handleNightModeChanged,
        isNightMode: isNightModeEnabled,
      ),
      body: isSelected
          ? const GlowingButtonBody()
          : CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: CustomHeaderWidget(text: 'Support tickets'),
                ),
                SliverToBoxAdapter(
                  child: Container(),
                )
              ],
            ),
    );
  }
}
