import 'og_info.dart';
import 'reactions.dart';
import 'user.dart';

class PostsModel {
  num id;
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
  num? commentsCount;
  num? sharesCount;
  OgInfo? ogInfo;
  List<dynamic>? misc;
  DateTime? createdAt;
  DateTime? updatedAt;

  PostsModel({
    required this.id,
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

  PostsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as num,
        user = json['user'] != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        page = json['page'],
        group = json['group'],
        content = json['content'] as String?,
        inNewsfeed = json['in_newsfeed'] as bool?,
        inStory = json['in_story'] as bool?,
        isVideoShort = json['is_video_short'] as bool?,
        isEvent = json['is_event'] as bool?,
        toCloseFriends = json['to_close_friends'] as bool?,
        isProcessing = json['is_processing'] as bool?,
        uploads = json['uploads'] as List<dynamic>?,
        // reactions = json['reactions'] != null
        //     ? Reactions.fromJson(json['reactions'] as Map<String, dynamic>)
        //     : null,
        comments = json['comments'] as List<dynamic>?,
        commentsCount = json['comments_count'] as num?,
        sharesCount = json['shares_count'] as num?,
        ogInfo = json['og_info'] != null
            ? OgInfo.fromJson(json['og_info'] as Map<String, dynamic>)
            : null,
        // misc = json['misc'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user?.toJson();
    data['page'] = page;
    data['group'] = group;
    data['content'] = content;
    data['in_newsfeed'] = inNewsfeed;
    data['in_story'] = inStory;
    data['is_video_short'] = isVideoShort;
    data['is_event'] = isEvent;
    data['to_close_friends'] = toCloseFriends;
    data['is_processing'] = isProcessing;
    data['uploads'] = uploads;
    data['reactions'] = reactions?.toJson();
    data['comments'] = comments;
    data['comments_count'] = commentsCount;
    data['shares_count'] = sharesCount;
    data['og_info'] = ogInfo?.toJson();
    data['misc'] = misc;
    data['created_at'] = createdAt?.toString();
    data['updated_at'] = updatedAt?.toString();
    return data;
  }
}
