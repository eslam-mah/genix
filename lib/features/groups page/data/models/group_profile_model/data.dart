import 'group.dart';
import 'posts.dart';

class Data {
  Group? group;
  List<dynamic>? suggested;
  Posts? posts;

  Data({this.group, this.suggested, this.posts});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        group: json['group'] == null
            ? null
            : Group.fromJson(json['group'] as Map<String, dynamic>),
        suggested: json['suggested'] as List<dynamic>?,
        posts: json['posts'] == null
            ? null
            : Posts.fromJson(json['posts'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'group': group?.toJson(),
        'suggested': suggested,
        'posts': posts?.toJson(),
      };
}
