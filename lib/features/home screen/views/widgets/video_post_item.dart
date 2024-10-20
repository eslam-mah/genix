import 'package:flutter/material.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:video_player/video_player.dart';

class VideoPlayerPostItem extends StatefulWidget {
  final String video;

  const VideoPlayerPostItem({
    super.key,
    required this.video,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerPostItemState createState() => _VideoPlayerPostItemState();
}

class _VideoPlayerPostItemState extends State<VideoPlayerPostItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayerDialog(videoUrl: widget.video),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openVideoDialog(context),
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Center(
              child: const CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            )),
    );
  }
}

class VideoPlayerDialog extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerDialog({super.key, required this.videoUrl});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerDialogState createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller
              .play(); // Start playing the video immediately when dialog opens
          _isPlaying = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
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
                // Optionally: Add any UI elements like controls or loading indicators
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            )),
    );
  }
}
