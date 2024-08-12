import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/videoplayerpage.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';

class VideosGridView extends StatelessWidget {
  const VideosGridView({
    super.key,
    required this.height,
    required this.crossAxisCount,
    required this.direction,
    this.profileModel,
  });
  final double height;
  final int crossAxisCount;
  final Axis direction;
  final ProfileModel? profileModel;
  @override
  Widget build(BuildContext context) {
    final videos = profileModel?.data?.videos ?? [];
    if (videos.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: height,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videos.length > 4 ? 4 : videos.length,
          scrollDirection: direction,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return VideoPlayerWidget(
              videoUrl: videos[index],
              showMute: true,
              showPlay: true,
              shimmerWidth: 100.w,
              shimmerHeight: 60.h,
            );
          }),
    );
  }
}
