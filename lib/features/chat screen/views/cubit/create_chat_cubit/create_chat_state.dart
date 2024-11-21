part of 'create_chat_cubit.dart';

@immutable
sealed class CreateChatState {}

final class CreateChatInitial extends CreateChatState {}

class CreateChatLoading extends CreateChatState {}

class CreateChatSuccess extends CreateChatState {
  CreateChatRoomResponse createChatRoomResponse;

  CreateChatSuccess({
    required this.createChatRoomResponse,
  });
}

final class CreateChatError extends CreateChatState {}
