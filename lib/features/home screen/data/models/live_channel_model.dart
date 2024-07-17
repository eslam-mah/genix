import 'package:genix/features/users/data/models/users_list.dart';

class LiveChannelModel {
  int id;
  int? postId;
  String? name;
  UserList? attendees;
  String? createdAt;

  LiveChannelModel({
    required this.id,
    this.postId,
    this.name,
    this.attendees,
    this.createdAt,
  });

  LiveChannelModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        postId = json['post_id'],
        name = json['name'],
        attendees = json['attendees'] != null
            ? UserList.fromJson(json['attendees'])
            : null,
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_id'] = postId;
    data['name'] = name;
    if (attendees != null) {
      data['attendees'] = attendees!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}
