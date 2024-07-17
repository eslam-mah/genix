class UpdatePostForm {
  String type;
  String? content;
  List<String>? files;
  Map<String, dynamic>? filesToRemove;
  String? checkinLocation;
  String? pollQuestion;
  List<String>? pollOptions;
  String? eventTimestamp;
  String? userId;
  String? groupId;
  String? pageId;

  UpdatePostForm({
    required this.type,
    this.content,
    this.files,
    this.filesToRemove,
    this.checkinLocation,
    this.pollQuestion,
    this.pollOptions,
    this.eventTimestamp,
    this.userId,
    this.groupId,
    this.pageId,
  });

  UpdatePostForm.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        content = json['content'],
        files = json['files'] != null ? List<String>.from(json['files']) : null,
        filesToRemove = json['files_to_remove'],
        checkinLocation = json['checkin_location'],
        pollQuestion = json['poll_question'],
        pollOptions = json['poll_options'] != null
            ? List<String>.from(json['poll_options'])
            : null,
        eventTimestamp = json['event_timestamp'],
        userId = json['user_id'],
        groupId = json['group_id'],
        pageId = json['page_id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['content'] = content;
    data['files'] = files;
    data['files_to_remove'] = filesToRemove;
    data['checkin_location'] = checkinLocation;
    data['poll_question'] = pollQuestion;
    data['poll_options'] = pollOptions;
    data['event_timestamp'] = eventTimestamp;
    data['user_id'] = userId;
    data['group_id'] = groupId;
    data['page_id'] = pageId;
    return data;
  }
}
