import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/customdrawerwidget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';

import 'package:genix/core/widgets/glowingbuttonbody.dart';

import 'package:genix/features/home%20screen/widgets/customhomeappbar.dart';

import 'package:genix/features/home%20screen/widgets/postitem.dart';
import 'package:genix/features/home%20screen/widgets/storylist.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
        backgroundColor: AppColors.kAppBar2Color,
        elevation: 0,
        title: const CustomHomeAppBar(),
      ),
      endDrawer: CustomDrawerWidget(
        onNightModeChanged: handleNightModeChanged,
        isNightMode: isNightModeEnabled,
      ),
      body: isSelected
          ? const GlowingButtonBody()
          : CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderWidget(
                        text: 'Newsfeed',
                      ),
                      StoryList()
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: 500.w,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return PostItem(
                          isNightModeEnabled: isNightModeEnabled,
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
