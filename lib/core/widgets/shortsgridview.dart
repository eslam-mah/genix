import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';

class ShortsGridView extends StatelessWidget {
  const ShortsGridView({
    super.key,
    required this.height,
    required this.crossAxisCount,
  });
  final double height;
  final int crossAxisCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GridView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Image.asset(
              AppImages.kPost,
              height: 20.h,
              width: 20.h,
            );
          }),
    );
  }
}
