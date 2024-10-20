// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import 'package:genix/core/utils/colors.dart';

class PostMediaFiles extends StatefulWidget {
  FilePickerResult result;
  final List<VideoPlayerController?> videoControllers;
  PostMediaFiles({
    super.key,
    required this.result,
    required this.videoControllers,
  });

  @override
  State<PostMediaFiles> createState() => _PostMediaFilesState();
}

class _PostMediaFilesState extends State<PostMediaFiles> {
  bool isVideo(String fileName) {
    // Common video file extensions
    final videoExtensions = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'mkv', 'webm'];
    final fileExtension = fileName.split('.').last.toLowerCase();
    return videoExtensions.contains(fileExtension);
  }

  bool isImage(String fileName) {
    // Check file extension
    final extensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    final fileExtension = fileName.split('.').last.toLowerCase();
    return extensions.contains(fileExtension);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: widget.result.files.length > 3
              ? widget.result.files.length / 3 * 100.h
              : 100.h, // Adjust this based on your needs
          width: double.infinity,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Adjust the number of columns
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemCount: widget.result.files.length,
            itemBuilder: (context, index) {
              final file = widget.result.files[index];
              // Check if the file is an image or a video and display accordingly
              if (isImage(file.name)) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(file.path!)),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                );
              } else if (isVideo(file.name)) {
                final controller = widget.videoControllers[index];
                return controller != null && controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )
                    : const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
