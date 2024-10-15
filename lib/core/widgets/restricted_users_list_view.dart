import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/profilescard.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';

class RestrictedUsersListView extends StatelessWidget {
  const RestrictedUsersListView({
    super.key,
    required this.height,
    required this.profileModel,
  });
  final double height;
  final ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    final profile = profileModel.data?.restrictCollection ?? [];
    if (profile.isEmpty) {
      return Container();
    }
    return SizedBox(
        height: profile.length == 1 ? 60.h : height,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: profile.length > 2 ? 2 : profile.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: ProfilesCard(
                  userName: profile[index].user?.username ?? '',
                  imageUrl: profile[index].user?.profileImg ?? '',
                  showName: profile[index].user?.showname ?? '',
                  userBio: profile[index].user?.bio ?? '',
                  isActive: profile[index].user?.isActive ?? false,
                ),
              );
            }));
  }
}
