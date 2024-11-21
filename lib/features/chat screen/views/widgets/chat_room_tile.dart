import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/extension/date_time_extension.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/features/chat%20screen/models/chat_room.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart' show parse;

class ChatRoomTile extends StatelessWidget {
  final ChatRoom item;

  const ChatRoomTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    if (item.user == null && item.isGroup == 0) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          context.push(Rout.kChatScreen, extra: {'chatRoom': item});
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Ink(
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 56.0,
                  width: 56.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      imageUrl: item.user?.profileImg ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                          color: Colors.grey,
                          child: Container(
                            color: Colors.purple,
                            alignment: Alignment.center,
                            child: Text(
                                item.user?.showname
                                        ?.split('')
                                        .take(2)
                                        .join()
                                        .toUpperCase() ??
                                    '',
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.white)),
                          )),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.user?.showname ?? item.name ?? '',
                            ),
                          ),
                          Text(
                            item.lastMessage?.createdAt?.toTimeAgo() ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _removeHtmlTags(item.lastMessage?.content ?? ''),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          if (item.isUnread == true)
                            Container(
                              width: 12.0,
                              height: 12.0,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }
}
