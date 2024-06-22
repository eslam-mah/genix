import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';

class PhotosGridView extends StatelessWidget {
  const PhotosGridView({
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
          itemCount: 4,
          scrollDirection: direction,
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
