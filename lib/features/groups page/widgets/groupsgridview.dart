import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/my%20profile%20screen/widgets/groupscard.dart';

class GroupsGridView extends StatelessWidget {
  const GroupsGridView({
    super.key,
    required this.height,
    required this.crossAxisCount,
    required this.direction,
  });
  final double height;
  final int crossAxisCount;
  final Axis direction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: GridView.builder(
            scrollDirection: direction,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 1.2,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
                child: const GroupsCard(),
              );
            }));
  }
}
