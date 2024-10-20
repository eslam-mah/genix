import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/cubit/user_cubit/user_cubit.dart';
import 'package:genix/core/services/locator.dart';
import 'package:genix/features/chat%20screen/models/chat_room_messages.dart';
import 'package:genix/features/chat%20screen/views/video_player_screen.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';

class ChatBubble extends StatefulWidget {
  final Message message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final UserCubit _userCubit = locator<UserCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: widget.message.user?.id == _userCubit.state.id ? Alignment.topRight : Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(
              top: 12.0,
              left: widget.message.user?.id == _userCubit.state.id ? 10.0 : 0,
            ),
            // padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: widget.message.user?.id == _userCubit.state.id ? Colors.green.withOpacity(0.9) : Colors.grey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the content (if available)
                if (widget.message.content != null && widget.message.content!.trim().isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      _removeHtmlTags(widget.message.content ?? ""),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                // Display the uploads (images, videos)
                if (widget.message.uploads != null && widget.message.uploads!.isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.message.uploads!
                        .map(
                          (upload) => Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                            child: _buildUploadWidget(upload, context),
                          ),
                        )
                        .toList(),
                  ),

                // ...message.uploads!.map(
                //   (upload) => Container(
                //     constraints: const BoxConstraints(maxWidth: 250),
                //     padding: const EdgeInsets.only(
                //       top: 8.0,
                //       left: 8.0,
                //       right: 8.0,
                //       bottom: 8.0,
                //     ),
                //     child: _buildUploadWidget(upload, context),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        if (widget.message.createdAt != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: widget.message.user?.id == _userCubit.state.id ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(
                  formatDateTime(DateTime.parse(widget.message.createdAt!)) ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  // Helper method to handle uploads and check the file type
  Widget _buildUploadWidget(Upload upload, BuildContext context) {
    if (upload.type != null && upload.type!.contains('image/svg+xml')) {
      // Display SVG images
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SvgPicture.network(
          upload.fileUrl!,
          height: 150,
          width: 150,
        ),
      );
    } else if (upload.type != null && upload.type!.contains('image/')) {
      // Display regular images (PNG, JPEG, etc.)
      return InkWell(
        onTap: () {
          print('Image tapped ${upload.fileUrl}');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: upload.fileUrl!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else if (upload.type == 'video/mp4') {
      // If video, check if there's a thumbnail in the aux field
      String? thumbnailUrl;
      if (upload.aux != null && upload.aux!.isNotEmpty) {
        final auxThumbnail = upload.aux!.firstWhere(
          (aux) => aux.type == 'thumbnail',
          orElse: () => Aux(type: 'thumbnail', upload: Upload(fileUrl: '', type: '')),
        );
        thumbnailUrl = auxThumbnail.upload!.fileUrl;
      }
      return _buildVideoWidget(upload.fileUrl!, thumbnailUrl, context);
    } else {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.fileArrowDown,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  upload.filename ?? 'Unsupported file type',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ); // For unsupported file types
    }
  }

  // Video Player widget with thumbnail
  Widget _buildVideoWidget(String videoUrl, String? thumbnailUrl, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              videoUrl: videoUrl,
              isMuted: true,
              showPlay: true,
            ),
          ),
        );
      },
      child: thumbnailUrl != null
          ? SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          imageUrl: thumbnailUrl,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 150,
              width: 150,
              color: Colors.black,
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
    );
  }
}

String formatDateTime(DateTime dateTime) {
  // You can customize the format string as needed
  return DateFormat('KK:mm dd/MM/yyyy ').format(dateTime);
}
