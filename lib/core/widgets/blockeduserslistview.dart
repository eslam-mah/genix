import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/profilescard.dart';

class BlockedListView extends StatelessWidget {
  const BlockedListView({
    super.key,
    required this.height,
  });
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: const ProfilesCard(),
              );
            }));
  }
}
