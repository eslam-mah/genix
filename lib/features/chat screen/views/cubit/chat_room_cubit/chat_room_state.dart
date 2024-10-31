part of 'chat_room_cubit.dart';

class ChatRoomState {
  final List<Message> messages;
  final bool? loadingState;
  final int? page;
  final int? limit;
  final String? roomId;

  ChatRoomState({this.messages = const [], this.loadingState = false, this.page = 1, this.limit = 100, this.roomId}) : super();

  ChatRoomState copyWith({
    List<Message>? messages,
    bool? loadingState,
    int? page,
    int? limit,
    String? roomId,
  }) {
    return ChatRoomState(
      messages: messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      roomId: roomId ?? this.roomId,
    );
  }
}

final class ChatRoomInitial extends ChatRoomState {
  final List<Message> messages;
  final bool? loadingState;
  final int? page;
  final int? limit;
  final String? roomId;

  ChatRoomInitial({
    this.messages = const [],
    this.loadingState = false,
    this.page,
    this.limit,
    this.roomId,
  }) : super(messages: [], loadingState: true, page: page, limit: limit, roomId: roomId);

  ChatRoomInitial copyWith({
    List<Message>? messages,
    bool? loadingState,
    int? page,
    int? limit,
    String? roomId,
  }) {
    return ChatRoomInitial(
      messages: messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      roomId: roomId ?? this.roomId,
    );
  }
}

final class ChatRoomLoading extends ChatRoomState {
  final List<Message>? message;
  final bool? loadingState;
  int? page;
  int? limit;
  String? roomId;

  ChatRoomLoading({this.message, this.loadingState = false, this.page, this.limit, this.roomId})
      : super(messages: message ?? [], loadingState: loadingState, page: page, limit: limit, roomId: roomId);

  ChatRoomLoading copyWith({
    List<Message>? messages,
    bool? loadingState,
    int? page,
    int? limit,
    String? roomId,
  }) {
    return ChatRoomLoading(
      message: messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      roomId: roomId ?? this.roomId,
    );
  }
}

final class ChatRoomSuccess extends ChatRoomState {
  final List<Message> messages;
  final bool? loadingState;
  int? page;
  int? limit;
  String? roomId;

  ChatRoomSuccess(this.messages, {this.loadingState = false, this.page, this.limit, this.roomId})
      : super(messages: messages, loadingState: loadingState, page: page, limit: limit, roomId: roomId);

  ChatRoomSuccess copyWith({List<Message>? messages, bool? loadingState, int? page, int? limit, String? roomId}) {
    return ChatRoomSuccess(
      messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      roomId: roomId ?? this.roomId,
    );
  }
}

final class ChatRoomError extends ChatRoomState {
  final String error;

  final List<Message> messages;
  final bool? loadingState;
  int? page;
  int? limit;
  String? roomId;

  ChatRoomError(this.error, {this.messages = const [], this.loadingState = false, this.page, this.limit, this.roomId})
      : super(messages: messages, loadingState: loadingState, page: page, limit: limit, roomId: roomId);

  ChatRoomError copyWith({String? error, List<Message>? messages, bool? loadingState, int? page, int? limit, String? roomId}) {
    return ChatRoomError(
      error ?? this.error,
      messages: messages ?? this.messages,
      loadingState: loadingState ?? this.loadingState,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      roomId: roomId ?? this.roomId,
    );
  }
}
