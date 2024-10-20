import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/cubit/handler_cubit/handler_cubit.dart';
import 'package:genix/core/cubit/user_cubit/user_cubit.dart';
import 'package:genix/core/services/locator.dart';
import 'package:genix/features/chat%20screen/models/chat_room.dart';
import 'package:genix/features/chat%20screen/views/cubit/chat_room_cubit/chat_room_cubit.dart';
import 'package:genix/features/chat%20screen/views/cubit/file_picker_cubit/file_picker_cubit.dart';
import 'package:genix/features/chat%20screen/views/widgets/chat_message_buble.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final ChatRoom chatRoom;

  const ChatScreen({super.key, required this.chatRoom});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatRoomCubit _chatRoomCubit = ChatRoomCubit();
  final UserCubit _userCubit = locator<UserCubit>();
  final HandlerCubit<bool> _emojiViewCubit = HandlerCubit(false);
  final FilePickerCubit _filePickerCubit = FilePickerCubit();

  @override
  void initState() {
    super.initState();
    _chatRoomCubit.getChatRoomMessages(id: widget.chatRoom.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emojiViewCubit.update(false);
      },
      child: Scaffold(
        appBar: _buildAppBar(widget.chatRoom),
        body: Column(
          children: [
            Expanded(
              child: _buildChatList(),
            ),
            BlocBuilder<HandlerCubit<bool>, bool>(
              bloc: _emojiViewCubit,
              builder: (context, emojiShowing) {
                return Offstage(
                  offstage: !emojiShowing,
                  child: EmojiPicker(
                    textEditingController: _messageController,

                    // scrollController: _scrollController,
                    config: Config(
                      height: 256,
                      checkPlatformCompatibility: true,
                      viewOrderConfig: const ViewOrderConfig(),
                      emojiViewConfig: EmojiViewConfig(
                        emojiSizeMax: 28 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.2 : 1.0),
                      ),
                      skinToneConfig: const SkinToneConfig(),
                      categoryViewConfig: const CategoryViewConfig(),
                      bottomActionBarConfig: const BottomActionBarConfig(
                        backgroundColor: Colors.green,
                        showSearchViewButton: false,
                        showBackspaceButton: false,
                      ),
                      searchViewConfig: const SearchViewConfig(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            _buildFilePreview(_filePickerCubit), // Add file preview here
            _buildMessageInput(chatRoomCubit: _chatRoomCubit, filePickerCubit: _filePickerCubit),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(ChatRoom chatRoom) {
    return AppBar(
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      title: chatRoom.name != null
          ? Row(
              children: [
                const Icon(Icons.group, color: Colors.white, size: 40),
                const SizedBox(width: 10),
                Text(chatRoom.name ?? "", style: const TextStyle(color: Colors.white)),
              ],
            )
          : Text(chatRoom.user?.showname ?? "", style: const TextStyle(color: Colors.white)),
      actions: [
        IconButton(icon: const Icon(Icons.call, color: Colors.white), onPressed: () {}),
        IconButton(icon: const Icon(Icons.videocam_rounded, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  Widget _buildChatList() {
    return BlocBuilder<ChatRoomCubit, ChatRoomState>(
      bloc: _chatRoomCubit,
      builder: (context, stateMessage) {
        if (stateMessage is ChatRoomLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (stateMessage is ChatRoomError) {
          return Center(child: Text(stateMessage.error));
        } else if (stateMessage is ChatRoomSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            controller: _scrollController,
            reverse: true,
            itemCount: stateMessage.messages.length + 1,
            itemBuilder: (context, index) {
              if (index == stateMessage.messages.length) {
                return Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return ChatBubble(
                message: stateMessage.messages[index],
              );
            },
          );
        } else {
          return const Center(child: Text("No messages found"));
        }
      },
    );
  }

  Widget _buildMessageInput({required ChatRoomCubit chatRoomCubit, required FilePickerCubit filePickerCubit}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle, size: 30),
            onPressed: () {
              _filePickerCubit.pickMultipleFiles();
            },
          ),
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
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {
                      _emojiViewCubit.update(!_emojiViewCubit.state);
                    },
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.mic),
                  //   onPressed: () {
                  //     // Voice recording action
                  //   },
                  // ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded, size: 30),
            onPressed: () {
              chatRoomCubit.sendMessage(
                roomId: widget.chatRoom.id.toString(),
                message: _messageController.text,
                files: filePickerCubit.state.files ?? [],
              );
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }

  _buildFilePreview(FilePickerCubit filePickerCubit) {
    return BlocBuilder<FilePickerCubit, FilePickerState>(
      bloc: filePickerCubit,
      builder: (context, state) {
        if (state is FilePickerSuccess && state.files.isNotEmpty) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.files.length,
              itemBuilder: (context, index) {
                PlatformFile file = state.files[index];
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Card(
                        elevation: 4,
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: 140, // Fixed width for each preview
                          height: 140, // Fixed height for each preview
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _getFilePreviewWidget(file),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    file.name,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: const Icon(Icons.cancel, color: Colors.black, size: 20),
                          onTap: () {
                            filePickerCubit.removeFile(index);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return SizedBox.shrink(); // Hide if no files selected
      },
    );
  }

  Widget _getFilePreviewWidget(PlatformFile file) {
    final extension = file.extension ?? '';
    if (['jpg', 'png', 'jpeg'].contains(extension)) {
      // Display image preview
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(file.path!), // Ensure you have 'import 'dart:io';'
          height: 100,
          width: 150,
          fit: BoxFit.fill,
        ),
      );
    } else if (['mp4', 'mov', 'avi'].contains(extension)) {
      // Display video icon
      return const Center(
        child: Icon(FontAwesomeIcons.fileVideo, color: Colors.red, size: 40),
      );
    } else if (['pdf'].contains(extension)) {
      // Display PDF icon
      return const Center(
        child: Icon(FontAwesomeIcons.filePdf, color: Colors.blue, size: 40),
      );
    } else {
      // Display generic file icon
      return const Center(
        child: Icon(FontAwesomeIcons.file, color: Colors.green, size: 40),
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    // Your message sending logic here

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    // Clear the message input after sending
    _messageController.clear();
  }
}
