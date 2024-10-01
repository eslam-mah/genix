class PostForm {
  String? content;
  String? pageId;
  String? groupId;
  String? postingIn;
  List<String>? files;
  String? checkinLocation;
  String? pollQuestion;
  List<String>? pollOptions;
  String? eventTimestamp;
  String? microphoneId;
  String? cameraId;
  bool? cameraMirror;
  String? deviceType;
  bool? isLive;
  bool? toCloseFriends;
  bool? event;
  bool? poll;
  bool? checkin;

  PostForm({
    this.content,
    this.pageId,
    this.groupId,
    this.postingIn,
    this.files,
    this.checkinLocation,
    this.pollQuestion,
    this.pollOptions,
    this.eventTimestamp,
    this.microphoneId,
    this.cameraId,
    this.cameraMirror,
    this.deviceType,
    this.isLive,
    this.toCloseFriends,
    this.event,
    this.poll,
    this.checkin,
  }) {}

  PostForm.fromJson(Map<String, dynamic> json)
      : content = json['content'] as String?,
        pageId = json['page_id'] as String?,
        groupId = json['group_id'] as String?,
        postingIn = json['posting_in'] as String?,
        files = json['files'] as List<String>,
        checkinLocation = json['checkin_location'] as String?,
        pollQuestion = json['poll_question'] as String?,
        pollOptions = json['poll_options'] as List<String>?,
        eventTimestamp = json['event_timestamp'] as String?,
        microphoneId = json['microphone_id'] as String?,
        cameraId = json['camera_id'] as String?,
        cameraMirror = json['camera_mirror'] as bool?,
        deviceType = json['device_type'] as String?,
        isLive = json['is_live'] as bool?,
        toCloseFriends = json['to_close_friends'] as bool?,
        event = json['event'] as bool?,
        poll = json['poll'] as bool?,
        checkin = json['checkin'] as bool? {
    if (checkinLocation != null && checkinLocation!.length < 1) {
      throw ArgumentError(
          "Check-in location must be at least 1 character long.");
    }
    if (pollQuestion != null && pollQuestion!.length < 1) {
      throw ArgumentError("Poll question must be at least 1 character long.");
    }
    if (pollOptions != null && pollOptions!.isEmpty) {
      throw ArgumentError("Poll options must have at least 1 item.");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = this.content;
    data['page_id'] = this.pageId;
    data['group_id'] = this.groupId;
    data['posting_in'] = this.postingIn;
    data['files'] = this.files;
    data['checkin_location'] = this.checkinLocation;
    data['poll_question'] = this.pollQuestion;
    data['poll_options'] = this.pollOptions;
    data['event_timestamp'] = this.eventTimestamp;
    data['microphone_id'] = this.microphoneId;
    data['camera_id'] = this.cameraId;
    data['camera_mirror'] = this.cameraMirror;
    data['device_type'] = this.deviceType;
    data['is_live'] = this.isLive;
    data['to_close_friends'] = this.toCloseFriends;
    data['event'] = this.event;
    data['poll'] = this.poll;
    data['checkin'] = this.checkin;
    return data;
  }
}
