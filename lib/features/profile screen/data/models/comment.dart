import 'reactions.dart';
import 'user.dart';

class Comment {
  int? id;
  User? user;
  int? postId;
  String? content;
  Reactions? reactions;
  DateTime? createdAt;

  Comment({
    this.id,
    this.user,
    this.postId,
    this.content,
    this.reactions,
    this.createdAt,
  });

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        postId = json['post_id'],
        content = json['content'],
        reactions = json['reactions'] != null
            ? Reactions.fromJson(json['reactions'])
            : null,
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user?.toJson();
    data['post_id'] = this.postId;
    data['content'] = this.content;
    data['reactions'] = this.reactions?.toJson();
    data['created_at'] = this.createdAt?.toIso8601String();
    return data;
  }
}
