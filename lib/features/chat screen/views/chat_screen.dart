import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:http/http.dart' as http;
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/cubit/handler_cubit/handler_cubit.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/chat%20screen/models/chat_room.dart';
import 'package:genix/features/chat%20screen/views/cubit/chat_room_cubit/chat_room_cubit.dart';
import 'package:genix/features/chat%20screen/views/cubit/file_picker_cubit/file_picker_cubit.dart';
import 'package:genix/features/chat%20screen/views/widgets/chat_message_buble.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/agora/pusher_service_for_call.dart';
import '../../../core/localization/all_app_strings.dart';
import '../../../core/utils/api_end_points.dart';

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
  final HandlerCubit<bool> _emojiViewCubit = HandlerCubit(false);
  final FilePickerCubit _filePickerCubit = FilePickerCubit();
  Timer? _messageFetchTimer;
  @override
  void initState() {
    print('chat room is ${widget.chatRoom.id}');
    super.initState();
    _chatRoomCubit.initializePusher();
    _chatRoomCubit.getChatRoomMessages(id: widget.chatRoom.id.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _messageFetchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _chatRoomCubit.getChatRoomMessages2(id: widget.chatRoom.id.toString());
      });
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _chatRoomCubit.fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    _messageFetchTimer?.cancel(); // Cancel the timer to prevent memory leaks
    _messageController.dispose();
    _scrollController.dispose();
    _chatRoomCubit.close();
    _emojiViewCubit.close();
    _filePickerCubit.close();
    super.dispose();
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
                        emojiSizeMax: 28 *
                            (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                ? 1.2
                                : 1.0),
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
            _buildMessageInput(
                chatRoomCubit: _chatRoomCubit,
                filePickerCubit: _filePickerCubit),
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
                Text(chatRoom.name ?? "",
                    style: const TextStyle(color: Colors.white)),
              ],
            )
          : Text(chatRoom.user?.showname ?? "",
              style: const TextStyle(color: Colors.white)),
      actions: [
        // Audio Call Button
        IconButton(
          icon: const Icon(Icons.call, color: Colors.white),
          onPressed: () async {
            print('audio call start');
            await initiateCall(widget.chatRoom.id.toString(), false);
            print('audio call end');
          },
        ),

        IconButton(
          icon: const Icon(Icons.videocam_rounded, color: Colors.white),
          onPressed: () async {
            initiateCall(widget.chatRoom.id.toString(), true);
          },
        ),
      ],
    );
  }

  Widget _buildChatList() {
    return BlocBuilder<ChatRoomCubit, ChatRoomState>(
      bloc: _chatRoomCubit,
      builder: (context, stateMessage) {
        // Show loading indicator while messages are loading
        if (stateMessage is ChatRoomLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            ),
          );
        }

        // Show error message if there is an issue
        else if (stateMessage is ChatRoomError) {
          return Center(child: Text(stateMessage.error));
        }

        // Display chat messages when loading is done
        else if (stateMessage is ChatRoomSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            controller: _scrollController,
            reverse: true, // Makes the list scroll to the bottom
            itemCount: stateMessage.loadingState == true
                ? stateMessage.messages.length +
                    1 // Show loading indicator at the end if new messages are loading
                : stateMessage.messages.length,
            itemBuilder: (context, index) {
              // Show loading indicator at the bottom if more messages are being loaded
              if (stateMessage.loadingState == true &&
                  index == stateMessage.messages.length) {
                return const Center(child: CircularProgressIndicator());
              }

              // Show each chat message
              return ChatBubble(
                message: stateMessage.messages[index],
              );
            },
          );
        }

        // Display a message when no chat messages are found
        else {
          return Center(
              child: Text('${AppStrings.nomessagesfound.getString(context)}'));
        }
      },
    );
  }

  Widget _buildMessageInput(
      {required ChatRoomCubit chatRoomCubit,
      required FilePickerCubit filePickerCubit}) {
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
                      decoration: InputDecoration(
                        hintText:
                            '${AppStrings.typeamessage.getString(context)}',
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
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded, size: 30),
            onPressed: () {
              chatRoomCubit.sendMessage(
                roomId: widget.chatRoom.id ?? 0,
                message: _messageController.text.trim(),
                files: filePickerCubit.files,
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
                File file = state.files[index];
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    file.toString(),
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
                          child: const Icon(Icons.cancel,
                              color: Colors.black, size: 20),
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

  Widget _getFilePreviewWidget(File file) {
    String getFileExtension(File file) {
      return file.path.split('.').last.toLowerCase();
    }

    final extension = getFileExtension(file);
    if (['jpg', 'png', 'jpeg'].contains(extension)) {
      // Display image preview
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(file.path), // Ensure you have 'import 'dart:io';'
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

  Future<void> initiateCall(String room, bool isVideo) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(PrefKeys.kToken);

      if (token == null) {
        throw Exception('Authorization token is missing. Please log in again.');
      }

      final String url = '${ApiEndPoints.baseUrl}/chat/calls/channel/$room';

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final body = {
        'users': [],
        'with_video': isVideo,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 202) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true && responseData['data'] != null) {
          final channelData = responseData['data'];

          // Safely access the channel properties
          final String channelName = channelData['name']?.toString() ?? 'Unknown Channel';
          final String channelId = channelData['id']?.toString() ?? '';
          final bool withVideo = channelData['with_video'] ?? false;

          // Safely handle participants
          final List<dynamic> participants = channelData['participants'] ?? [];
          final String firstParticipant = participants.isNotEmpty &&
              participants.first['user'] != null ?
          participants.first['user']['showname'] ?? 'Unknown' :
          'Unknown';

          print('Channel Name: $channelName');
          print('Channel ID: $channelId');
          print('First Participant: $firstParticipant');

          // Get Agora token
          String agoraToken = await getAgoraToken(channelId);
          await CallPusherManager().notifyCall(channelId);
           navigateToCallScreen(channelName, agoraToken, withVideo);
        } else {
          throw Exception('Invalid response structure: ${response.body}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      print('Error in initiateCall: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to initiate call: $e');
    }
  }

  Future<String> getAgoraToken(String channelId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(PrefKeys.kToken);

      if (token == null) {
        throw Exception('Authorization token is missing');
      }

      final response = await http.post(
        Uri.parse('${ApiEndPoints.baseUrl}/agora/chat/$channelId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Agora Token Response Status: ${response.statusCode}');
      print('Agora Token Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 202) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true && responseData['data'] != null) {
          // The data field contains the token string directly
          return responseData['data'].toString();
        } else {
          throw Exception('Invalid token response format');
        }
      } else {
        throw Exception('Failed to get Agora token. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error getting Agora token: $e');
      throw Exception('Failed to get Agora token: $e');
    }
  }

  void navigateToCallScreen(String channelName, String token, bool isVideo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallScreen(
          channelName: channelName,
          token: token,
          isVideo: isVideo,
        ),
      ),
    );
  }

}



class CallScreen extends StatefulWidget {
  final String channelName;
  final String token;
  final bool isVideo;

  const CallScreen({
    super.key,
    required this.channelName,
    required this.token,
    required this.isVideo,
  });

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late RtcEngine _engine;
  bool _localUserJoined = false;
  bool _muted = false;
  bool _speakerOn = true;
  int? _remoteUid;

  @override
  void initState() {
    super.initState();
    _initializeAgora();
  }

  Future<void> _initializeAgora() async {
    // Create RTC Engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "7e5b7e4afd464ed997dd189920c656af",
    ));

    // Set event handlers
    _engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (connection, elapsed) {
        setState(() {
          _localUserJoined = true;
        });
      },
      onUserJoined: (connection, uid, elapsed) {
        setState(() {
          _remoteUid = uid;
        });
      },
      onUserOffline: (connection, uid, reason) {
        setState(() {
          _remoteUid = null;
        });
      },
    ));

    // Enable video if it's a video call
    if (widget.isVideo) {
      await _engine.enableVideo();
      await _engine.startPreview();
    }

    // Join the channel
    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  // Build video view for remote user
  Widget _buildRemoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Waiting for other user to join...',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  // Build video view for local user
  Widget _buildLocalVideo() {
    return _localUserJoined
        ? AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    )
        : const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Build UI for audio call
  Widget _buildAudioCall() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.phone_in_talk, size: 80, color: Colors.green),
          const SizedBox(height: 20),
          Text(
            _remoteUid != null ? 'Call Connected' : 'Waiting for other user...',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                _muted = !_muted;
              });
              _engine.muteLocalAudioStream(_muted);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: _muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              _muted ? Icons.mic_off : Icons.mic,
              color: _muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                _speakerOn = !_speakerOn;
              });
              _engine.setEnableSpeakerphone(_speakerOn);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: _speakerOn ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              _speakerOn ? Icons.volume_up : Icons.volume_off,
              color: _speakerOn ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.isVideo ? 'Video Call' : 'Audio Call'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Main call view
          widget.isVideo
              ? Stack(
            children: [
              Center(child: _buildRemoteVideo()),
              Positioned(
                top: 90,
                right: 20,
                child: Container(
                  width: 120,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildLocalVideo(),
                  ),
                ),
              ),
            ],
          )
              : _buildAudioCall(),
          // Controls overlay
          _buildControls(),
        ],
      ),
    );
  }
}
