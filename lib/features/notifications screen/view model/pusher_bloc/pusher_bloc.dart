import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/features/notifications%20screen/data/services/notification_services.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'dart:convert';

part 'pusher_event.dart';
part 'pusher_state.dart';

class PusherBloc extends Bloc<PusherEvent, PusherState> {
  late PusherChannelsFlutter pusher;
  late PusherChannel chatChannel;

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

  Future<void> _onPusherConnect(
      PusherConnect event, Emitter<PusherState> emit) async {
    String token = CacheData.getData(key: PrefKeys.kToken);
    try {
      pusher = PusherChannelsFlutter.getInstance();
      await pusher.init(
        apiKey: "bea6d82af19725b37bd4",
        cluster: "eu",
        authEndpoint: 'https://api.genix.social/api/broadcasting/auth',
        authParams: {
          "headers": {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        },
        onConnectionStateChange: (String currentState, String previousState) {
          print("Connection state changed: $previousState -> $currentState");
        },
        onError: (String message, int? code, dynamic e) {
          print("Error: $message");
        },
      );

      await pusher.connect();

      chatChannel = await pusher.subscribe(
        channelName: '.chat.message.sent',
        onEvent: _onEvent2,
      );

      emit(PusherConnected());
    } catch (e) {
      print("Pusher init failed: $e");
    }
  }

  void _onEvent2(PusherEvent event) {
    print(
        '___________________________________ sending message ___________________________');
  }

  void _onEvent(PusherEvent event) {
    // Log the raw event object
    print("Received event: $event");

    try {
      // Assume event is a string representation of JSON and try to decode it
      final rawEvent = event
          .toString(); // Use `toString()` to get a string representation of the event
      final decodedData = jsonDecode(rawEvent);

      // Access event name and data from decoded JSON
      final eventName = decodedData['event'] ?? '';
      final eventData = decodedData['data'] ?? '';

      if (eventName.isNotEmpty && eventData.isNotEmpty) {
        // Add events based on eventName
        switch (eventName) {
          case '.chat.message.sent':
            add(PusherMessageSent(eventData));
            break;
          case '.chat.message.read':
            add(PusherMessageRead(eventData));
            break;
          case '.chat.call.store':
            add(PusherCallStore(eventData));
            break;
          case '.chat.call.update':
            add(PusherCallUpdate(eventData));
            break;
          case '.chat.call.delete':
            add(PusherCallDelete(eventData));
            break;
          case '.posts.comment':
            add(PusherPostComment(eventData));
            break;
          case '.posts.live.update':
            add(PusherLiveUpdate(eventData));
            break;
          case '.posts.my-post.updated':
            add(PusherMyPostUpdated(eventData));
            break;
          default:
            print("Unhandled event: $eventName");
        }
      } else {
        print("Event has missing or unexpected data structure");
      }
    } catch (e) {
      print("Error while processing or decoding event data: $e");
    }
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
