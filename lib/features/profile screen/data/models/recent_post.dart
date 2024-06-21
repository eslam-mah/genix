import 'og_info.dart';
import 'reactions.dart';
import 'user.dart';

class RecentPost {
  int? id;
  User? user;
  dynamic page;
  dynamic group;
  String? content;
  bool? inNewsfeed;
  bool? inStory;
  bool? isVideoShort;
  bool? isEvent;
  bool? toCloseFriends;
  bool? isProcessing;
  List<dynamic>? uploads;
  Reactions? reactions;
  List<dynamic>? comments;
  int? commentsCount;
  int? sharesCount;
  OgInfo? ogInfo;
  List<dynamic>? misc;
  DateTime? createdAt;
  DateTime? updatedAt;

  RecentPost({
    this.id,
    this.user,
    this.page,
    this.group,
    this.content,
    this.inNewsfeed,
    this.inStory,
    this.isVideoShort,
    this.isEvent,
    this.toCloseFriends,
    this.isProcessing,
    this.uploads,
    this.reactions,
    this.comments,
    this.commentsCount,
    this.sharesCount,
    this.ogInfo,
    this.misc,
    this.createdAt,
    this.updatedAt,
  });

  RecentPost.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        page = json['page'],
        group = json['group'],
        content = json['content'],
        inNewsfeed = json['in_newsfeed'],
        inStory = json['in_story'],
        isVideoShort = json['is_video_short'],
        isEvent = json['is_event'],
        toCloseFriends = json['to_close_friends'],
        isProcessing = json['is_processing'],
        uploads = json['uploads'],
        reactions = json['reactions'] != null
            ? Reactions.fromJson(json['reactions'])
            : null,
        comments = json['comments'],
        commentsCount = json['comments_count'],
        sharesCount = json['shares_count'],
        ogInfo =
            json['og_info'] != null ? OgInfo.fromJson(json['og_info']) : null,
        misc = json['misc'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user?.toJson();
    data['page'] = this.page;
    data['group'] = this.group;
    data['content'] = this.content;
    data['in_newsfeed'] = this.inNewsfeed;
    data['in_story'] = this.inStory;
    data['is_video_short'] = this.isVideoShort;
    data['is_event'] = this.isEvent;
    data['to_close_friends'] = this.toCloseFriends;
    data['is_processing'] = this.isProcessing;
    data['uploads'] = this.uploads;
    data['reactions'] = this.reactions?.toJson();
    data['comments'] = this.comments;
    data['comments_count'] = this.commentsCount;
    data['shares_count'] = this.sharesCount;
    data['og_info'] = this.ogInfo?.toJson();
    data['misc'] = this.misc;
    data['created_at'] = this.createdAt?.toString();
    data['updated_at'] = this.updatedAt?.toString();
    return data;
  }
}
