import 'page.dart';
import 'posts.dart';

class Data {
  Page? page;
  List<dynamic>? suggested;
  Posts? posts;

  Data({this.page, this.suggested, this.posts});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json['page'] == null
            ? null
            : Page.fromJson(json['page'] as Map<String, dynamic>),
        suggested: json['suggested'] as List<dynamic>?,
        posts: json['posts'] == null
            ? null
            : Posts.fromJson(json['posts'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'page': page?.toJson(),
        'suggested': suggested,
        'posts': posts?.toJson(),
      };
}
