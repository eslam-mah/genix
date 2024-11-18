part of 'pusher_bloc.dart';

abstract class PusherState extends Equatable {
  const PusherState();

  @override
  List<Object> get props => [];
}

class PusherInitial extends PusherState {}

class PusherConnected extends PusherState {}

class PusherMessageReceived extends PusherState {
  final String message;
  const PusherMessageReceived(this.message);
}

class PusherMessageReadState extends PusherState {
  final String message;
  const PusherMessageReadState(this.message);
}

class PusherCallStored extends PusherState {
  final String data;
  const PusherCallStored(this.data);
}

class PusherCallUpdated extends PusherState {
  final String data;
  const PusherCallUpdated(this.data);
}

class PusherCallDeleted extends PusherState {
  final String data;
  const PusherCallDeleted(this.data);
}

class PusherPostCommentReceived extends PusherState {
  final String data;
  const PusherPostCommentReceived(this.data);
}

class PusherLiveUpdated extends PusherState {
  final String data;
  const PusherLiveUpdated(this.data);
}

class PusherMyPostStateUpdated extends PusherState {
  final String data;
  const PusherMyPostStateUpdated(this.data);
}
