import 'package:flutter/material.dart';
import 'package:genix/features/chat%20screen/models/chat_room.dart';
import 'package:genix/features/chat%20screen/views/widgets/chat_room_tile.dart';

class ChatListingScreen extends StatelessWidget {
  const ChatListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: ListView.builder(
        itemCount: ChatRoom.dummyData.length,
        itemBuilder: (context, index) {
          ChatRoom item = ChatRoom.dummyData[index];
          return ChatRoomTile(item: item);
        },
      ),
    );
  }
}
