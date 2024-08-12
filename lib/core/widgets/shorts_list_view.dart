import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/videoplayerpage.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';

class ShortsListView extends StatelessWidget {
  const ShortsListView({
    super.key,
    required this.height,
    required this.profileModel,
  });
  final double height;
  final ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    final shortVideos = profileModel.data?.postedShorts ?? [];
    if (shortVideos.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: height,
      child: ListView.builder(
          itemCount: shortVideos.length > 4 ? 4 : shortVideos.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: VideoPlayerWidget(
                videoUrl: shortVideos[index].fileUrl ?? '',
                showMute: false,
                showPlay: false,
                shimmerWidth: 100.w,
                shimmerHeight: 100.h,
              ),
            );
          }),
    );
  }
}
