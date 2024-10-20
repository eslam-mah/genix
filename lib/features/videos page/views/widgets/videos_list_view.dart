import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/video_player_page.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';
import 'package:genix/features/profile%20screen/views/widgets/video_profile_item.dart';

class VideosGridView extends StatelessWidget {
  const VideosGridView({
    super.key,
    this.profileModel,
  });
  final ProfileModel? profileModel;
  @override
  Widget build(BuildContext context) {
    final videos = profileModel?.data?.videos ?? [];
    if (videos.isEmpty) {
      return Container();
    }
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.w,
            childAspectRatio: 1.2),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: videos.length > 4 ? 4 : videos.length,
        itemBuilder: (context, index) {
          return VideoPlayerProfileItem(
            video: videos[index].fileUrl ?? "",
            shimmerWidth: 120.w,
            shimmerHeight: 120.w,
          );
        });
  }
}
