import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';
import 'package:video_player/video_player.dart';

class VideoShortPlayerItem extends StatefulWidget {
  final ShortsModel video;

  const VideoShortPlayerItem({
    super.key,
    required this.video,
  });

  @override
  _VideoShortPlayerItemState createState() => _VideoShortPlayerItemState();
}

class _VideoShortPlayerItemState extends State<VideoShortPlayerItem> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showIcon = true;
  bool _isMuted = false;
  Timer? _hideIconTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video.fileUrl ?? "")
      ..initialize().then((_) {
        setState(() {
          _controller.setVolume(_isMuted ? 0.0 : 1.0); // Set initial volume
          _controller.play(); // Start playing automatically
          _isPlaying = true;
          _startHideIconTimer(); // Start timer to hide the icon after one second
        });
      });

    // Add a listener to restart the video when it reaches the end
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _controller.seekTo(Duration.zero); // Go back to the start
        _controller.play(); // Replay the video
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideIconTimer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
      _showIcon = true; // Show icon on tap
      _startHideIconTimer(); // Start timer to hide the icon after one second
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _startHideIconTimer() {
    _hideIconTimer?.cancel(); // Cancel any existing timer
    _hideIconTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _showIcon = false; // Hide icon after 2 seconds
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                if (_showIcon)
                  Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 80,
                    color: Colors.white.withOpacity(0.7),
                  ),
                Positioned(
                  top: 35.h,
                  left: 12.w,
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Center(
                          child: Icon(
                            _isMuted
                                ? FontAwesomeIcons.volumeXmark
                                : FontAwesomeIcons.volumeHigh,
                            color: Colors.white,
                            size: 20.r,
                          ),
                        ),
                        onPressed: _toggleMute,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: AppColors.kPrimaryColor),
            ),
    );
  }
}
