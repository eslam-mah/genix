import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/customimagewidget.dart';
import 'package:genix/features/followers%20list%20page/views/view/followers_page.dart';
import 'package:genix/features/profile%20screen/views/view/my_profile_page.dart';
import 'package:genix/features/settings%20screen/views/view/settings_page.dart';
import 'package:genix/features/support%20tickets%20screen/views/view/support_tickets_page.dart';
import 'package:genix/features/video%20shorts%20screen/views/videoshortsbody.dart';
import 'package:go_router/go_router.dart';

class GlowingButtonBody extends StatelessWidget {
  const GlowingButtonBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImageIcon(
                image: AppImages.kMyProfile,
                text: 'My profile',
                onTap: () {
                  GoRouter.of(context).push(MyProfilePage.route);
                },
                duration: 200,
              ),
              CustomImageIcon(
                image: AppImages.kPhotos,
                text: 'Photos',
                onTap: () {
                  GoRouter.of(context).push(Rout.kPhotosScreen);
                },
                duration: 300,
              ),
              CustomImageIcon(
                image: AppImages.kVideo,
                text: 'Videos',
                onTap: () {
                  GoRouter.of(context).push(Rout.kVideosScreen);
                },
                duration: 400,
              ),
            ],
          ),
          SizedBox(
            height: 20.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImageIcon(
                image: AppImages.kGroups,
                text: 'Groups',
                onTap: () {
                  GoRouter.of(context).push(Rout.kGroupsScreen);
                },
                duration: 500,
              ),
              CustomImageIcon(
                image: AppImages.kPages,
                text: 'Pages',
                onTap: () {
                  GoRouter.of(context).push(Rout.kPagesScreen);
                },
                duration: 600,
              ),
              CustomImageIcon(
                image: AppImages.kFollowers,
                text: 'Followers',
                onTap: () {
                  GoRouter.of(context)
                      .push(FollowersPage.route, extra: FollowersPageArgs());
                },
                duration: 700,
              ),
            ],
          ),
          SizedBox(
            height: 20.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImageIcon(
                image: AppImages.kSettings,
                text: 'Settings',
                onTap: () {
                  GoRouter.of(context).push(SettingsPage.route);
                },
                duration: 800,
              ),
              CustomImageIcon(
                image: AppImages.kVideoShorts,
                text: 'Video shorts',
                onTap: () {
                  GoRouter.of(context).push(VideoShortsBody.route);
                },
                duration: 900,
              ),
              CustomImageIcon(
                image: AppImages.kSupportTickets,
                text: 'Support tickets',
                onTap: () {
                  GoRouter.of(context).push(
                    SupportTicketsPage.route,
                  );
                },
                duration: 1000,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
