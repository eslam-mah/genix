import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:genix/core/cubit/user_cubit/user_cubit.dart';
import 'package:genix/core/services/locator.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/features/chat%20screen/data/repos/chat_repository.dart';
import 'package:genix/features/chat%20screen/models/chat_room_messages.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(ChatRoomInitial());

  ChatRepository chatRepository = ChatRepository();
  final UserCubit _userCubit = locator<UserCubit>();
  late PusherClient _pusher;
  late Channel _channel;

  void initializePusher()async {

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(PrefKeys.kToken);
    if(token == null){
      print(' token is null');
      return;
    }
    final headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    _pusher = PusherClient(
      "bea6d82af19725b37bd4",
      PusherOptions(
        cluster: "eu",
        auth: PusherAuth(
          'https://api.genix.social/api/broadcasting/auth',
          headers: headers,
        ),
      ),
      autoConnect: true,
    );

    _channel = _pusher.subscribe("chat-room");
    _bindEvents();
    _pusher.connect();
  }

  void _bindEvents() {
    _channel.bind("chat.message.sent", (PusherEvent? event) {
      if (event?.data != null) {
        final newMessage = Message.fromJson(json.decode(event!.data!));
        _addNewMessage(newMessage);
      }
    });

    // Bind call store event
    _channel.bind("chat.call.store", (PusherEvent? event) {
      // Handle the 'chat.call.store' event
      if (event?.data != null) {
        final data = json.decode(event!.data!);
        // Process the event data here
        print('Call store event: $data');
      }
    });

    // Bind call update event
    _channel.bind("chat.call.update", (PusherEvent? event) {
      // Handle the 'chat.call.update' event
      if (event?.data != null) {
        final data = json.decode(event!.data!);
        // Process the event data here
        print('Call update event: $data');
      }
    });
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
    _pusher.unsubscribe("chat-room");
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
