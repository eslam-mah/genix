import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genix/core/extension/date_time_extension.dart';
import 'package:genix/features/chat%20screen/models/chat_room.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom item;

  const ChatRoomTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8.0),
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xffDBDADDFF),
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
                        imageUrl: 'https://picsum.photos/250?image=9'),
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
                            style: TextStyle(
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
                              item.lastMessage?.content ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
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
}
