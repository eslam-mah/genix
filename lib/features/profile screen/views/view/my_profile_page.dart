import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/blockeduserslistview.dart';
import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/followingslistview.dart';
import 'package:genix/core/widgets/restricteduserslistview.dart';
import 'package:genix/core/widgets/saved_shorts.dart';
import 'package:genix/core/widgets/shorts_list_view.dart';
import 'package:genix/features/followers%20list%20page/views/widgets/followers_list_view.dart';
import 'package:genix/features/groups%20page/widgets/groups_list_view.dart';
import 'package:genix/features/profile%20screen/view%20model/get%20profile/get_profile_cubit.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_icon_listview.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_profile_header.dart';
import 'package:genix/features/photos%20page/widgets/photos_List_view.dart';
import 'package:genix/features/profile%20screen/views/widgets/recent_posts_list.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/videos%20page/widgets/videos_list_view.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({
    super.key,
  });
  static const String route = '/my_profile';
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;

  bool isNightModeEnabled = false;

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<GetMyAccountDetailsCubit>().getMyAccountDetails();
  }

  void _getProfile(String username) {
    context.read<GetProfileCubit>().getProfile(profileName: username);
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
              bottom: 20.h,
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
      body: BlocBuilder<GetMyAccountDetailsCubit, GetMyAccountDetailsState>(
        builder: (context, state) {
          if (state is GetMyAccountDetailsLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            ));
          } else if (state is GetMyAccountDetailsSuccess) {
            final username = state.account.data?.username;
            _getProfile(username ?? '');
            return BlocBuilder<GetProfileCubit, GetProfileState>(
              builder: (context, state) {
                if (state is GetProfileLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ));
                } else if (state is GetProfileSuccess) {
                  final profileModel = state.profiles;
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            CustomProfileHeader(
                              imageUrl:
                                  state.profiles.data?.user?.profileImg ?? '',
                              profileName:
                                  state.profiles.data?.user?.showname ?? '',
                              followersCount:
                                  state.profiles.data?.followersCount ?? 0,
                              friendsCount:
                                  state.profiles.data?.followingCount ?? 0,
                              likesCount:
                                  state.profiles.data?.reactionsCount ?? 0,
                              savedCount: state.profiles.data?.postsCount ?? 0,
                              bioText: state.profiles.data?.user?.bio ?? '',
                              coverImageUrl:
                                  state.profiles.data?.user?.coverImg ?? '',
                            ),
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
                                          child: CustomHeaderWidget2(
                                              text: 'Photos')),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Text(
                                            'See all',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  PhotosGridView(
                                    height: 110.h,
                                    crossAxisCount: 2,
                                    direction: Axis.horizontal,
                                    profileModel: profileModel,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: CustomHeaderWidget2(
                                              text: 'Videos')),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Text(
                                            'See all',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  VideosGridView(
                                    height: 200.h,
                                    crossAxisCount: 2,
                                    direction: Axis.horizontal,
                                    profileModel: profileModel,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: CustomHeaderWidget2(
                                              text: 'Shorts')),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Text(
                                            'See all',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  ShortsListView(
                                      height: 200.h, profileModel: profileModel)
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: CustomHeaderWidget2(
                                              text: 'Saved shorts')),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Text(
                                            'See all',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  SavedShortsListView(
                                    height: 200.h,
                                    profileModel: profileModel,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: CustomHeaderWidget2(
                                              text: 'Recent posts')),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Text(
                                            'See all',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  RecentPostsList(profileModel: profileModel)
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
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  FollowersListView(
                                      height: 170.h, profileModel: profileModel)
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
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  FollowingsListView(
                                      height: 150.h, profileModel: profileModel)
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: CustomHeaderWidget2(
                                              text: 'Blocked')),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Text(
                                            'See all',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  BlockedListView(
                                      height: 150.h, profileModel: profileModel)
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: CustomHeaderWidget2(
                                              text: 'Groups')),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Text(
                                            'See all',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  GroupsGridView(
                                      height: 130.h,
                                      crossAxisCount: 2,
                                      direction: Axis.vertical,
                                      profileModel: profileModel)
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
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                  RestrictedUsersListView(
                                      height: 150.h, profileModel: profileModel)
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else if (state is GetProfileError) {
                  return const Center(child: Text('Error loading profile'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (state is GetMyAccountDetailsError) {
            return const Center(child: Text('Error loading account details'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
