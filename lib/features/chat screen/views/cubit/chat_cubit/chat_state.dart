part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatSuccessState extends ChatState {
  List<ChatRoom> chatRooms;
  ChatSuccessState({required this.chatRooms});
}

final class ChatFailureState extends ChatState {}
