import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:genix/core/cubit/user_cubit/user_cubit.dart';
import 'package:genix/core/services/locator.dart';
import 'package:genix/features/chat%20screen/data/repos/chat_repository.dart';
import 'package:genix/features/chat%20screen/models/chat_room_messages.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(ChatRoomInitial());

  ChatRepository chatRepository = ChatRepository();
  final UserCubit _userCubit = locator<UserCubit>();

  void getChatRoomMessages({required String id}) async {
    emit(ChatRoomLoading(
      loadingState: true,
      message: [],
      page: 1,
      limit: 100,
      roomId: id,
    ));

    final result = await chatRepository.getChatRoomMessagesById(id: id, page: 1, limit: 10);
    print("result: $result");
    result.fold((l) => emit(ChatRoomError("Something went wrong")), (r) {
      ChatRoomMessagesResponse chatRoomMessagesResponse = ChatRoomMessagesResponse.fromJson(r as Map<String, dynamic>);
      emit(ChatRoomSuccess(chatRoomMessagesResponse.data?.messages ?? [], page: 1, limit: 100, roomId: id));
    });
  }

  void fetchNextPage() async {
    emit(state.copyWith(page: state.page! + 1, limit: 10, loadingState: true));
    final result = await chatRepository.getChatRoomMessagesById(id: state.roomId ?? "", page: state.page, limit: state.limit);
    result.fold((l) => emit(state.copyWith(loadingState: false)), (r) {
      ChatRoomMessagesResponse chatRoomMessagesResponse = ChatRoomMessagesResponse.fromJson(r as Map<String, dynamic>);
      List<Message> messages = state.messages;
      List<Message> newMessages = List.from(messages)..addAll(chatRoomMessagesResponse.data?.messages ?? []);
      emit(state.copyWith(messages: newMessages, page: state.page, limit: 100, loadingState: false));
    });
  }

  void sendMessage({required String roomId, required String message, List<PlatformFile>? files}) async {
    Message newMessage = Message(
      id: Random().nextInt(1000),
      roomId: int.parse(roomId),
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
      message: message,
      files: files,
    );
    result.fold((l) async {
      // silentChatRoomMessages(id: roomId);
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
    final result = await chatRepository.getChatRoomMessagesById(id: id, page: state.page, limit: state.limit);
    print("result: $result");
    result.fold(
        (l) => emit(ChatRoomError(
              "Something went wrong",
              page: state.page,
              limit: state.limit,
            )), (r) {
      ChatRoomMessagesResponse chatRoomMessagesResponse = ChatRoomMessagesResponse.fromJson(r as Map<String, dynamic>);
      emit(
        ChatRoomSuccess(
          chatRoomMessagesResponse.data?.messages ?? [],
          page: state.page,
          limit: state.limit,
        ),
      );
    });
  }
}
