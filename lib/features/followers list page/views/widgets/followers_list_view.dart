import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/profilescard.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';

class FollowersListView extends StatelessWidget {
  const FollowersListView({
    super.key,
    required this.height,
    this.profileModel,
  });
  final double height;
  final ProfileModel? profileModel;
  @override
  Widget build(BuildContext context) {
    final followers = profileModel?.data?.followersCollection ?? [];
    if (followers.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
        height: followers.length == 1 ? 100.h : height,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: followers.length > 2 ? 2 : followers.length,
            itemBuilder: (context, index) {
              print(
                  'ddddddddddddddddd${followers.length}____________________________ssss_sss____-');
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: ProfilesCard(
                  userName: followers[index].user?.username ?? '',
                  imageUrl: followers[index].user?.profileImg ?? '',
                  showName: followers[index].user?.showname ?? '',
                  userBio: followers[index].user?.bio ?? '',
                  isActive: followers[index].user?.isActive ?? false,
                ),
              );
            }));
  }
}
