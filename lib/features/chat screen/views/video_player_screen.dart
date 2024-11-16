import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../core/localization/all_app_strings.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  final bool showPlay;
  final double? iconSize;
  final bool? showFullScreenButton;
  final bool isMuted; // Add this to control mute state

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.showPlay,
    this.showFullScreenButton,
    required this.isMuted,
    this.iconSize, // Initialize isMuted
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
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
      var videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
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
  void didUpdateWidget(covariant VideoPlayerScreen oldWidget) {
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
    return Scaffold(
      appBar: AppBar(
        title:  Text('${AppStrings.video.getString(context)}'),
      ),
      body: hasError
          ?  Center(child: Text('${AppStrings.errorloadingvideo.getString(context)}'))
          : isInitialized
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
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}
