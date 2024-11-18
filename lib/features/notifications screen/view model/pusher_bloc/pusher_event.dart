part of 'pusher_bloc.dart';

abstract class PusherEvent extends Equatable {
  const PusherEvent();

  @override
  List<Object> get props => [];
}

class PusherConnect extends PusherEvent {}

class PusherMessageSent extends PusherEvent {
  final String message;
  const PusherMessageSent(this.message);
}

class PusherMessageRead extends PusherEvent {
  final String message;
  const PusherMessageRead(this.message);
}

class PusherCallStore extends PusherEvent {
  final String data;
  const PusherCallStore(this.data);
}

class PusherCallUpdate extends PusherEvent {
  final String data;
  const PusherCallUpdate(this.data);
}

class PusherCallDelete extends PusherEvent {
  final String data;
  const PusherCallDelete(this.data);
}

class PusherPostComment extends PusherEvent {
  final String data;
  const PusherPostComment(this.data);
}

class PusherLiveUpdate extends PusherEvent {
  final String data;
  const PusherLiveUpdate(this.data);
}

class PusherMyPostUpdated extends PusherEvent {
  final String data;
  const PusherMyPostUpdated(this.data);
}
