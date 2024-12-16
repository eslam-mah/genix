import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:genix/core/cubit/user_cubit/user_cubit.dart';
import 'package:genix/core/services/locator.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/features/chat%20screen/data/repos/chat_repository.dart';
import 'package:genix/features/chat%20screen/models/chat_room_messages.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(ChatRoomInitial());

  ChatRepository chatRepository = ChatRepository();
  final UserCubit _userCubit = locator<UserCubit>();
  late PusherChannelsFlutter _pusher;
  late PusherChannel _channel;

  void initializePusher() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(PrefKeys.kToken);
    if (token == null) {
      print('Token is null');
      return;
    }

    final headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    try {
      _pusher = PusherChannelsFlutter.getInstance();
      await _pusher.init(
        apiKey: "bea6d82af19725b37bd4",
        cluster: "eu",
        authEndpoint: 'https://api.genix.social/api/broadcasting/auth',
        authParams: {
          "headers": headers,
        },
        onConnectionStateChange: (String currentState, String previousState) {
          print("Connection state changed: $previousState -> $currentState");
        },
        onError: (String message, int? code, dynamic e) {
          print("Error: $message");
        },
      );

      await _pusher.connect();

      _channel = await _pusher.subscribe(
        channelName: 'chat-room',
        onEvent: _onEvent,
      );
    } catch (e) {
      print("Pusher init failed: $e");
    }
  }

  void _onEvent(PusherEvent event) {
    try {
      // Log the received event for debugging purposes
      print("Received event: $event");

      // Assume event data is a JSON string, parse it
      final decodedData = jsonDecode(event.data);

      // Handle different events based on `eventName`
      switch (event.eventName) {
        case 'chat.message.sent':
          final newMessage = Message.fromJson(decodedData);
          _addNewMessage(newMessage);
          break;

        case 'chat.call.store':
          print('Call store event: $decodedData');
          break;

        case 'chat.call.update':
          print('Call update event: $decodedData');
          break;

        default:
          print("Unhandled event: ${event.eventName}");
      }
    } catch (e) {
      print("Error processing event: $e");
    }
  }

  void _addNewMessage(Message message) {
    if (state is ChatRoomSuccess) {
      final currentState = state as ChatRoomSuccess;
      final updatedMessages = List<Message>.from(currentState.messages)
        ..add(message); // Add new message to the list
      emit(ChatRoomSuccess(updatedMessages,
          page: currentState.page,
          limit: currentState.limit,
          roomId: currentState.roomId));
    }
  }

  @override
  Future<void> close() {
    _pusher.unsubscribe(channelName: "chat-room");
    _pusher.disconnect();
    return super.close();
  }

  void getChatRoomMessages({required String id}) async {
    emit(ChatRoomLoading(
      loadingState: true,
      message: [],
      page: 1,
      limit: 100,
      roomId: id,
    ));

    final result = await chatRepository.getChatRoomMessagesById(
        id: id, page: 1, limit: 10);
    print("result: $result");
    result.fold((l) => emit(ChatRoomError("Something went wrong")), (r) {
      ChatRoomMessagesResponse chatRoomMessagesResponse =
          ChatRoomMessagesResponse.fromJson(r as Map<String, dynamic>);
      emit(ChatRoomSuccess(chatRoomMessagesResponse.data?.messages ?? [],
          page: 1, limit: 100, roomId: id));
    });
  }

  void fetchNextPage() async {
    emit(state.copyWith(page: state.page! + 1, limit: 10, loadingState: true));
    final result = await chatRepository.getChatRoomMessagesById(
        id: state.roomId ?? "", page: state.page, limit: state.limit);
    result.fold((l) => emit(state.copyWith(loadingState: false)), (r) {
      ChatRoomMessagesResponse chatRoomMessagesResponse =
          ChatRoomMessagesResponse.fromJson(r as Map<String, dynamic>);
      List<Message> messages = state.messages;
      List<Message> newMessages = List.from(messages)
        ..addAll(chatRoomMessagesResponse.data?.messages ?? []);
      emit(state.copyWith(
          messages: newMessages,
          page: state.page,
          limit: 100,
          loadingState: false));
    });
  }

  void sendMessage(
      {required int roomId, required String message, List<File>? files}) async {
    Message newMessage = Message(
      id: Random().nextInt(1000),
      roomId: roomId,
      user: _userCubit.state,
      content: message,
      uploads: null,
      isProcessing: false,
      isNotification: false,
      createdAt: DateTime.now().toString(),
    );
    List<Message> messages = state.messages;
    messages.insert(0, newMessage);
    emit(state.copyWith(messages: messages, loadingState: true));
    print('roomId: $roomId, message: $message');
    print("state.messages: ${state.messages.length}");
    final result = await chatRepository.sendMessage(
      id: roomId,
      content: message,
      files: files!,
    );
    result.fold((l) async {
      emit(
        state.copyWith(
          loadingState: false,
          messages: messages,
        ),
      );
    }, (r) {
      emit(state.copyWith(loadingState: false));
    });
  }

  void silentChatRoomMessages({required String id}) async {
    final result = await chatRepository.getChatRoomMessagesById(
        id: id, page: state.page, limit: state.limit);
    print("result: $result");
    result.fold(
        (l) => emit(ChatRoomError(
              "Something went wrong",
              page: state.page,
              limit: state.limit,
            )), (r) {
      ChatRoomMessagesResponse chatRoomMessagesResponse =
          ChatRoomMessagesResponse.fromJson(r as Map<String, dynamic>);
      emit(
        ChatRoomSuccess(
          chatRoomMessagesResponse.data?.messages ?? [],
          page: state.page,
          limit: state.limit,
        ),
      );
    });
  }

  void getChatRoomMessages2({required String id}) async {
    final result = await chatRepository.getChatRoomMessagesById(
        id: id, page: 1, limit: 10);
    print("result: $result");
    result.fold((l) => emit(ChatRoomError("Something went wrong")), (r) {
      ChatRoomMessagesResponse chatRoomMessagesResponse =
          ChatRoomMessagesResponse.fromJson(r as Map<String, dynamic>);
      emit(ChatRoomSuccess(chatRoomMessagesResponse.data?.messages ?? [],
          page: 1, limit: 100, roomId: id));
    });
  }
}
