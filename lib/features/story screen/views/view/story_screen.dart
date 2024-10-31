import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/home%20screen/data/models/stories_list.dart';
import 'package:go_router/go_router.dart';
import 'package:story/story_page_view.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryScreen extends StatelessWidget {
  static const String routeName = '/story_screen';
  final StoryList storyList;
  final int startingStoryIndex;

  const StoryScreen({
    super.key,
    required this.storyList,
    required this.startingStoryIndex,
  });

  bool _isVideo(String url) {
    return url.endsWith('.mp4') || url.endsWith('.mov') || url.endsWith('.avi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StoryPageView(
          initialPage: startingStoryIndex,
          itemBuilder: (context, pageIndex, storyIndex) {
            final story =
                storyList.data.stories[pageIndex].collection?[storyIndex];
            final pageStory = storyList.data.stories[pageIndex];

            // Example timestamp (in seconds), convert to DateTime
            int timestampInSeconds = story?.time ?? 0;
            DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);

            // Format using timeago
            String timeAgo = timeago.format(dateTime);

            print(timeAgo); // Outputs something like "2 hours ago"

            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black),
                ),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: _isVideo(story?.url ?? '')
                      ? VideoPlayerWidget(url: story?.url ?? '')
                      : CachedNetworkImage(
                          imageUrl: story?.url ?? '',
                          height: 450.h,
                        ),
                ),
                // Positioned(
                //     left: 10.w,
                //     bottom: 10.h,
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: Colors.black,
                //           borderRadius: BorderRadius.circular(8.r)),
                //       height: 40.w,
                //       width: 100.w,
                //       child: Center(
                //         child: Text(
                //           "${story?.views ?? 0}Views",
                //           style:
                //               TextStyle(color: Colors.white, fontSize: 20.sp),
                //         ),
                //       ),
                //     )),
                Padding(
                  padding: EdgeInsets.only(top: 44.h, left: 8.w),
                  child: Row(
                    children: [
                      Container(
                        height: 32.w,
                        width: 32.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              pageStory.profileImg ?? '',
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        pageStory.showname ?? '',
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${timeAgo}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          gestureItemBuilder: (context, pageIndex, storyIndex) {
            return Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: Icon(
                    Icons.close,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          pageLength: storyList.data.stories.length,
          storyLength: (pageIndex) {
            return storyList.data.stories[pageIndex].collection?.length ?? 0;
          },
          onPageLimitReached: () {
            GoRouter.of(context).pop();
          },
          indicatorDuration: const Duration(seconds: 10),
          indicatorHeight: 2,
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(
            child: CircularProgressIndicator(
            color: AppColors.kPrimaryColor,
          ));
  }
}
