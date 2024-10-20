import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/profilescard.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';

class FollowersListView extends StatelessWidget {
  const FollowersListView({
    super.key,
    this.profileModel,
  });
  final ProfileModel? profileModel;
  @override
  Widget build(BuildContext context) {
    final followers = profileModel?.data?.followersCollection ?? [];
    if (followers.isEmpty) {
      return const SizedBox();
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
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
        });
  }
}
