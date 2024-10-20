import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/video_player_page.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';
import 'package:genix/features/profile%20screen/views/widgets/video_profile_item.dart';

class SavedShortsListView extends StatelessWidget {
  const SavedShortsListView({
    super.key,
    required this.profileModel,
  });
  final ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    final shortVideos = profileModel.data?.savedShorts ?? [];
    if (shortVideos.isEmpty) {
      return Container();
    }
    return GridView.builder(
      itemCount: shortVideos.length > 4 ? 4 : shortVideos.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: VideoPlayerProfileItem(
            video: shortVideos[index].fileUrl ?? "",
            shimmerWidth: 200.w,
            shimmerHeight: 300.w,
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
          childAspectRatio: 0.7),
    );
  }
}
