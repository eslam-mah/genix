import 'package:genix/features/home%20screen/data/models/posts_model/user.dart';

class Reaction {
  Map<String, int>? summary;
  dynamic byMe;

  Reaction({
    this.summary,
    this.byMe,
  });

  Reaction.fromJson(Map<String, dynamic> json)
      : summary = (json['summary'] as Map<String, dynamic>?)
            ?.map((k, e) => MapEntry(k, e as int)),
        byMe = json['by_me'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['summary'] = summary;
    data['by_me'] = byMe;
    return data;
  }
}

class Comment {
  int? id;
  User? user;
  int? postId;
  int? commentId;
  String? content;
  Reaction? reactions;
  DateTime? createdAt;

  Comment({
    this.id,
    this.user,
    this.postId,
    this.commentId,
    this.content,
    this.reactions,
    this.createdAt,
  });

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        user = (json['user'] != null ? User.fromJson(json['user']) : null),
        postId = json['post_id'] as int?,
        commentId = json['comment_id'] as int?,
        content = json['content'] as String?,
        // reactions = (json['reactions'] != null
        //     ? Reactions.fromJson(json['reactions'])
        //     : null),
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['post_id'] = postId;
    data['comment_id'] = commentId;
    data['content'] = content;
    if (reactions != null) {
      data['reactions'] = reactions!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}
