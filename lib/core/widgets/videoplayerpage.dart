// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter/material.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   const VideoPlayerWidget({super.key});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   CustomVideoPlayerController? customVideoPlayerController;

//   @override
//   void initState() {
//     super.initState();
//     initializeVideoPlayer();
//   }

//   void initializeVideoPlayer() async {
//     var videoPlayerController = CachedVideoPlayerController.network(
//         "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
//     await videoPlayerController.initialize();
//     setState(() {
//       customVideoPlayerController = CustomVideoPlayerController(
//           context: context, videoPlayerController: videoPlayerController);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return customVideoPlayerController == null
//         ? const CircularProgressIndicator(
//             color: Colors.green,
//           )
//         : CustomVideoPlayer(
//             customVideoPlayerController: customVideoPlayerController!);
//   }
// }
