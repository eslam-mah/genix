import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class CallService {
  late RtcEngine _engine;

  Future<void> initAgora() async {
    // Create an instance of the Agora engine
    _engine = createAgoraRtcEngine();

    // Initialize the engine
    await _engine.initialize(
      const RtcEngineContext(
        appId: "7e5b7e4afd464ed997dd189920c656af",
      ),
    );

    // Enable video (or audio-only if required)
    await _engine.enableVideo();
  }

  Future<void> joinChannel(String token, String channelName) async {
    await _engine.joinChannel(
      token: token,
      channelId: channelName,
      uid: 0, // Set user ID
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> leaveChannel() async {
    await _engine.leaveChannel();
  }
}
