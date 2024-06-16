import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/blockeduserslistview.dart';
import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view/customdrawerwidget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/followingslistview.dart';
import 'package:genix/core/widgets/glowingbuttonbody.dart';

import 'package:genix/core/widgets/restricteduserslistview.dart';
import 'package:genix/core/widgets/savedphotosandvideosview.dart';
import 'package:genix/core/widgets/shortsgridview.dart';
import 'package:genix/features/followers%20list%20page/widgets/followerslistview.dart';
import 'package:genix/features/groups%20page/widgets/groupsgridview.dart';
import 'package:genix/features/my%20profile%20screen/widgets/customiconlistview.dart';
import 'package:genix/features/my%20profile%20screen/widgets/customprofileheader.dart';

import 'package:genix/features/photos%20page/widgets/photosgridview.dart';
import 'package:genix/features/videos%20page/widgets/videosgridview.dart';

class MyProfileScreenBody extends StatefulWidget {
  const MyProfileScreenBody({super.key});

  @override
  State<MyProfileScreenBody> createState() => _MyProfileScreenBodyState();
}

class _MyProfileScreenBodyState extends State<MyProfileScreenBody> {
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
          title: const CustomAppBar(),
        ),
        endDrawer: CustomDrawerWidget(
          onNightModeChanged: handleNightModeChanged,
          isNightMode: isNightModeEnabled,
        ),
        body: isSelected
            ? const GlowingButtonBody()
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const CustomProfileHeader(),
                        SizedBox(
                          height: 8.h,
                        ),
                        const CustomIconButtonListView()
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child:
                                          CustomHeaderWidget2(text: 'Photos')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              PhotosGridView(
                                height: 200.h,
                                crossAxisCount: 2,
                                direction: Axis.horizontal,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child:
                                          CustomHeaderWidget2(text: 'Videos')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              VideosGridView(
                                height: 200.h,
                                crossAxisCount: 2,
                                direction: Axis.horizontal,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child:
                                          CustomHeaderWidget2(text: 'Shorts')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              ShortsGridView(
                                height: 200.h,
                                crossAxisCount: 2,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child:
                                          CustomHeaderWidget2(text: 'Saved')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              SavedPhotosAndVideosListView(
                                height: 200.h,
                                crossAxisCount: 2,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child: CustomHeaderWidget2(
                                          text: 'Followers')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              FollowersListView(
                                height: 150.h,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child: CustomHeaderWidget2(
                                          text: 'Following')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              FollowingsListView(
                                height: 150.h,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child:
                                          CustomHeaderWidget2(text: 'Blocked')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              BlockedListView(
                                height: 150.h,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child:
                                          CustomHeaderWidget2(text: 'Groups')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              GroupsGridView(
                                height: 130.h,
                                crossAxisCount: 2,
                                direction: Axis.vertical,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child: CustomHeaderWidget2(
                                          text: 'Restricted')),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              ),
                              RestrictedUsersListView(
                                height: 150.h,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
  }
}
