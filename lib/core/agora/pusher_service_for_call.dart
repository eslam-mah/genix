import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/agora/constants_for_call.dart';
import '../../core/utils/api_end_points.dart';
import '../../core/utils/pref_keys.dart';
import '../../features/chat screen/views/chat_screen.dart';

class CallPusherManager {
  static final CallPusherManager _instance = CallPusherManager._internal();
  factory CallPusherManager() => _instance;
  CallPusherManager._internal();

  late PusherClient pusher;
  late Channel channel;
  late BuildContext context;

  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> initialize() async {
    print('pusher is intialized');
    pusher = PusherClient(
      ConstantsForCall.pusherKey,
      PusherOptions(
        cluster: ConstantsForCall.pusherCluster,
        encrypted: true,
      ),
      autoConnect: true,
    );

    pusher.connect();

    pusher.onConnectionStateChange((state) {
      print("Pusher connection state: ${state?.currentState}");
    });

    pusher.onConnectionError((error) {
      print("Pusher connection error: ${error?.message}");
    });

    channel = pusher.subscribe('chat');

    channel.bind('call.store', (event) {
      print("Event received: ${event?.data}");
      if (event?.data != null) {
        final callData = json.decode(event!.data!);
        handleIncomingCall(callData);
      }
    });
  }

  void handleIncomingCall(Map<String, dynamic> callData) async {
    final channelName = callData['name']?.toString();
    final channelId = callData['id']?.toString();
    final withVideo = callData['with_video'] ?? false;

    if (channelId != null) {
      final token = await getAgoraToken(channelId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            channelName: channelName ?? '',
            token: token,
            isVideo: withVideo,
          ),
        ),
      );
    }
  }

  Future<String> getAgoraToken(String channelId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(PrefKeys.kToken);

    final response = await http.post(
      Uri.parse('${ApiEndPoints.baseUrl}/agora/chat/$channelId'),
      headers: await getAuthHeaders(),
    );

    if (response.statusCode == 202) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true && responseData['data'] != null) {
        return responseData['data'].toString();
      }
    }
    throw Exception('Failed to get Agora token');
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(PrefKeys.kToken);

    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<void> notifyCall(String channelId) async {
    final response = await http.post(
      Uri.parse('${ApiEndPoints.baseUrl}/chat/call/$channelId'),
      headers: await getAuthHeaders(),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to notify call: ${response.statusCode} - ${response.body}');
    }
  }


}

