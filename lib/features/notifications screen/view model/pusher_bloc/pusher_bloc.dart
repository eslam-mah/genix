import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/features/notifications%20screen/data/services/notification_services.dart';
import 'package:pusher_client/pusher_client.dart';
part 'pusher_event.dart';
part 'pusher_state.dart';

class PusherBloc extends Bloc<PusherEvent, PusherState> {
  late PusherClient pusher;
  late Channel chatChannel;

  PusherBloc() : super(PusherInitial()) {
    on<PusherConnect>(_onPusherConnect);
    on<PusherMessageSent>(_onPusherMessageSent);
    on<PusherMessageRead>(_onPusherMessageRead);
    on<PusherCallStore>(_onPusherCallStore);
    on<PusherCallUpdate>(_onPusherCallUpdate);
    on<PusherCallDelete>(_onPusherCallDelete);
    on<PusherPostComment>(_onPusherPostComment);
    on<PusherLiveUpdate>(_onPusherLiveUpdate);
    on<PusherMyPostUpdated>(_onPusherMyPostUpdated);
  }

  void _onPusherConnect(PusherConnect event, Emitter<PusherState> emit) {
    String token = CacheData.getData(key: PrefKeys.kToken);
    PusherOptions options = PusherOptions(
      cluster: "eu",
      encrypted: true,
      auth: PusherAuth(
        'https://api.genix.social/api/broadcasting/auth',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    pusher = PusherClient(
      "bea6d82af19725b37bd4",
      options,
      autoConnect: true,
    );

    pusher.connect();
    chatChannel = pusher.subscribe('chat-channel');

    // Listen for various events and add them to the bloc
    chatChannel.bind('.chat.message.sent', (event) {
      if (event != null) {
        add(PusherMessageSent(event.data ?? ''));
      }
    });

    chatChannel.bind('.chat.message.read', (event) {
      if (event != null) {
        add(PusherMessageRead(event.data ?? ''));
      }
    });

    chatChannel.bind('.chat.call.store', (event) {
      if (event != null) {
        add(PusherCallStore(event.data ?? ''));
      }
    });

    chatChannel.bind('.chat.call.update', (event) {
      if (event != null) {
        add(PusherCallUpdate(event.data ?? ''));
      }
    });

    chatChannel.bind('.chat.call.delete', (event) {
      if (event != null) {
        add(PusherCallDelete(event.data ?? ''));
      }
    });

    chatChannel.bind('.posts.comment', (event) {
      if (event != null) {
        add(PusherPostComment(event.data ?? ''));
      }
    });

    chatChannel.bind('.posts.live.update', (event) {
      if (event != null) {
        add(PusherLiveUpdate(event.data ?? ''));
      }
    });

    chatChannel.bind('.posts.my-post.updated', (event) {
      if (event != null) {
        add(PusherMyPostUpdated(event.data ?? ''));
      }
    });

    emit(PusherConnected());
  }

  void _onPusherMessageSent(
      PusherMessageSent event, Emitter<PusherState> emit) {
    emit(PusherMessageReceived(event.message));
    NotificationService.showNotification(
      title: "New Message",
      body: event.message,
    );
  }

  void _onPusherMessageRead(
      PusherMessageRead event, Emitter<PusherState> emit) {
    emit(PusherMessageReadState(event.message));
    NotificationService.showNotification(
      title: "Message Read",
      body: "A message in room ${event.message} was read.",
    );
  }

  void _onPusherCallStore(PusherCallStore event, Emitter<PusherState> emit) {
    emit(PusherCallStored(event.data));
    NotificationService.showNotification(
      title: "Incoming Call",
      body: "You have a new incoming call.",
    );
  }

  void _onPusherCallUpdate(PusherCallUpdate event, Emitter<PusherState> emit) {
    emit(PusherCallUpdated(event.data));
    NotificationService.showNotification(
      title: "Call Updated",
      body: "Call information has been updated.",
    );
  }

  void _onPusherCallDelete(PusherCallDelete event, Emitter<PusherState> emit) {
    emit(PusherCallDeleted(event.data));
    NotificationService.showNotification(
      title: "Call Ended",
      body: "The call has been ended.",
    );
  }

  void _onPusherPostComment(
      PusherPostComment event, Emitter<PusherState> emit) {
    emit(PusherPostCommentReceived(event.data));
    NotificationService.showNotification(
      title: "New Comment",
      body: "A new comment was added to your post.",
    );
  }

  void _onPusherLiveUpdate(PusherLiveUpdate event, Emitter<PusherState> emit) {
    emit(PusherLiveUpdated(event.data));
    NotificationService.showNotification(
      title: "Live Update",
      body: "A live post has been updated.",
    );
  }

  void _onPusherMyPostUpdated(
      PusherMyPostUpdated event, Emitter<PusherState> emit) {
    emit(PusherMyPostStateUpdated(event.data));
    NotificationService.showNotification(
      title: "Post Updated",
      body: "One of your posts has been updated.",
    );
  }

  @override
  Future<void> close() {
    pusher.disconnect();
    return super.close();
  }
}
