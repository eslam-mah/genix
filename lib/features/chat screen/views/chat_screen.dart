import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildChatList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // AppBar with group name and call/video call icons
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Row(
        children: [
          Icon(Icons.group, color: Colors.white, size: 40),
          SizedBox(width: 10),
          Text("NuSeStie", style: TextStyle(color: Colors.white)),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.call, color: Colors.white), onPressed: () {}),
        IconButton(icon: const Icon(Icons.videocam_rounded, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  // ListView for displaying chat messages
  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return ChatMessageWidget(
          message: message.text,
          isSentByMe: message.isSentByMe,
        );
      },
    );
  }

  // Input field for typing messages and send button
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          // Plus icon on the left
          IconButton(
            icon: const Icon(Icons.add_circle, size: 30),
            onPressed: () {
              // Action for adding media or other options
            },
          ),

          // TextField for typing a message
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // Emoji icon
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {
                      // Emoji action
                    },
                  ),

                  // Voice message icon
                  IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {
                      // Voice recording action
                    },
                  ),
                ],
              ),
            ),
          ),

          // Send button on the right
          IconButton(
            icon: const Icon(Icons.send_rounded, size: 30),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  List<bool> value = [true, false, true, false, true, false, true, false];
  int i = 0;

  // Send message method
  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    final message = Message(
      text: _messageController.text,
      isSentByMe: value[i],
    );
    i++;
    setState(() {
      _messages.add(message);
      _messageController.clear();
    });

    // Scroll to the bottom when a new message is added
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

// Message model class
class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}

// ChatMessageWidget for displaying individual messages
class ChatMessageWidget extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatMessageWidget({super.key, required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
