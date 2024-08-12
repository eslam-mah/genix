import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final double shimmerWidth;
  final double shimmerHeight;
  final bool showMute;
  final bool showPlay;
  final bool? showFullScreen;
  const VideoPlayerWidget(
      {super.key,
      required this.videoUrl,
      required this.showMute,
      required this.showPlay,
      required this.shimmerWidth,
      required this.shimmerHeight,
      this.showFullScreen});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  CustomVideoPlayerController? customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  void initializeVideoPlayer() async {
    var videoPlayerController =
        CachedVideoPlayerController.network(widget.videoUrl);
    await videoPlayerController.initialize();
    setState(() {
      customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController,
        customVideoPlayerSettings: CustomVideoPlayerSettings(
            showPlayButton: widget.showPlay,
            showMuteButton: widget.showMute,
            showFullscreenButton: widget.showFullScreen ?? true,
            showDurationPlayed: false,
            showSeekButtons: false,
            showDurationRemaining: false // Hide all controls
            ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return customVideoPlayerController == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: widget.shimmerWidth,
              height: widget.shimmerHeight,
              color: Colors.white,
            ),
          )
        : CustomVideoPlayer(
            customVideoPlayerController: customVideoPlayerController!,
          );
  }
}
