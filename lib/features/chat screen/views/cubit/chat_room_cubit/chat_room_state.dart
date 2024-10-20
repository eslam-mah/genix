part of 'chat_room_cubit.dart';

class ChatRoomState {
  final List<Message> messages;
  final bool? loadingState;

  ChatRoomState({this.messages = const [], this.loadingState = false});

  ChatRoomState copyWith({
    List<Message>? messages,
    bool? loadingState,
  }) {
    return ChatRoomState(
      messages: messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

final class ChatRoomInitial extends ChatRoomState {
  final List<Message> messages;
  final bool? loadingState;

  ChatRoomInitial({
    this.messages = const [],
    this.loadingState = false,
  }) : super(messages: [], loadingState: true);

  ChatRoomInitial copyWith({
    List<Message>? messages,
    bool? loadingState,
  }) {
    return ChatRoomInitial(
      messages: messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

final class ChatRoomLoading extends ChatRoomState {}

final class ChatRoomSuccess extends ChatRoomState {
  final List<Message> messages;
  final bool? loadingState;

  ChatRoomSuccess(this.messages, {this.loadingState = false});

  ChatRoomSuccess copyWith({
    List<Message>? messages,
    bool? loadingState,
  }) {
    return ChatRoomSuccess(
      messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

final class ChatRoomError extends ChatRoomState {
  final String error;

  final List<Message> messages;
  final bool? loadingState;

  ChatRoomError(this.error, {this.messages = const [], this.loadingState = false});

  ChatRoomError copyWith({
    String? error,
    List<Message>? messages,
    bool? loadingState,
  }) {
    return ChatRoomError(
      error ?? this.error,
      messages: messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
