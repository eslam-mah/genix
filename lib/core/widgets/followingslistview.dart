import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/profilescard.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';

class FollowingsListView extends StatelessWidget {
  const FollowingsListView({
    super.key,
    required this.profileModel,
  });
  final ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    final profile = profileModel.data?.followingCollection ?? [];
    if (profile.isEmpty) {
      return Container();
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: profile.length > 2 ? 2 : profile.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: ProfilesCard(
              imageUrl: profile[index].user?.profileImg ?? '',
              showName: profile[index].user?.showname ?? '',
              userBio: profile[index].user?.bio ?? '',
              isActive: profile[index].user?.isActive ?? false,
              userName: profile[index].user?.username ?? '',
            ),
          );
        });
  }
}
