import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final double shimmerWidth;
  final double shimmerHeight;
  final bool showPlay;
  final double? iconSize;
  final bool? showFullScreenButton;
  final bool isMuted; // Add this to control mute state

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.showPlay,
    required this.shimmerWidth,
    required this.shimmerHeight,
    this.showFullScreenButton,
    required this.isMuted,
    this.iconSize, // Initialize isMuted
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  FlickManager? flickManager;
  bool isInitialized = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    try {
      var videoPlayerController =
          VideoPlayerController.network(widget.videoUrl);
      await videoPlayerController.initialize();

      flickManager = FlickManager(
        videoPlayerController: videoPlayerController,
        onVideoEnd: () {
          flickManager!.flickControlManager?.pause();
        },
      );

      setState(() {
        isInitialized = true;
      });

      // Automatically play the video after initialization
      flickManager?.flickControlManager?.play();

      // Set mute based on the initial state
      if (widget.isMuted) {
        flickManager?.flickControlManager?.mute();
      }
    } catch (e) {
      print('________________________${e}__________________');
    }
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Mute/Unmute video when the isMuted prop changes
    if (widget.isMuted != oldWidget.isMuted) {
      if (widget.isMuted) {
        flickManager?.flickControlManager?.mute();
      } else {
        flickManager?.flickControlManager?.unmute();
      }
    }
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Center(child: Text("Error loading video"));
    }

    return isInitialized
        ? FlickVideoPlayer(
            flickManager: flickManager!,
            flickVideoWithControls: FlickVideoWithControls(
              videoFit: BoxFit.contain,
              controls: widget.showPlay
                  ? FlickPortraitControls(
                      iconSize: widget.iconSize ?? 20.sp,
                      progressBarSettings: FlickProgressBarSettings(
                        height: 5.h,
                      ),
                    )
                  : null,
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey[100]!,
            highlightColor: Colors.grey[50]!,
            child: Container(
              width: widget.shimmerWidth,
              height: widget.shimmerHeight,
              color: Colors.white,
            ),
          );
  }
}
