import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';
import 'package:genix/features/profile%20screen/views/widgets/groups_card.dart';

class GroupsGridView extends StatelessWidget {
  const GroupsGridView({
    super.key,
    required this.height,
    required this.crossAxisCount,
    required this.direction,
    this.profileModel,
    required this.isNightMode,
  });
  final double height;
  final int crossAxisCount;
  final Axis direction;
  final ProfileModel? profileModel;
  final bool isNightMode;
  @override
  Widget build(BuildContext context) {
    final group = profileModel?.data?.groupsCollection ?? [];
    if (group.isEmpty) {
      return Container();
    }
    return SizedBox(
        height: height,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: direction,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 1.1,
            ),
            itemCount: group.length > 2 ? 2 : group.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
                child: GroupsCard(
                  photoUrl: group[index].profileImg ?? '',
                  gpName: group[index].name ?? '',
                  membersNumber: group[index].membersCount ?? 0,
                ),
              );
            }));
  }
}
