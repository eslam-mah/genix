import 'package:genix/features/comments%20section/data/models/comments_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/misc.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/uploads.dart';

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
  List<Upload>? uploads;
  List<dynamic>? reactions;
  List<Comment>? comments;
  num? commentsCount;
  num? sharesCount;
  OgInfo? ogInfo;
  Misc? misc;
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
        uploads = json['uploads'] != null
            ? (json['uploads'] as List<dynamic>)
                .map((v) => Upload.fromJson(v as Map<String, dynamic>))
                .toList()
            : null,
        // reactions = json['reactions'] != null
        //     ? (json['reactions'] as List<dynamic>)
        //         .map((v) => Reactions.fromJson(v as Map<String, dynamic>))
        //         .toList()
        //     : null,

        comments = json['comments'] != null && json['comments'] is List<dynamic>
            ? (json['comments'] as List<dynamic>)
                .map((v) => Comment.fromJson(v as Map<String, dynamic>))
                .toList()
            : null,
        commentsCount = json['comments_count'] as num?,
        sharesCount = json['shares_count'] as num?,
        ogInfo = json['og_info'] != null
            ? OgInfo.fromJson(json['og_info'] as Map<String, dynamic>)
            : null,
        misc = json['misc'] is Map<String, dynamic> && json['misc'] != null
            ? Misc.fromJson(json['misc'] as Map<String, dynamic>)
            : null,
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['page'] = page;
    data['group'] = group;
    data['content'] = content;
    data['in_newsfeed'] = inNewsfeed;
    data['in_story'] = inStory;
    data['is_video_short'] = isVideoShort;
    data['is_event'] = isEvent;
    data['to_close_friends'] = toCloseFriends;
    data['is_processing'] = isProcessing;
    if (uploads != null) {
      data['uploads'] = uploads!.map((v) => v.toJson()).toList();
    }
    if (reactions != null) {
      data['reactions'] = reactions;
    }
    data['comments'] = comments;
    data['comments_count'] = commentsCount;
    data['shares_count'] = sharesCount;
    if (ogInfo != null) {
      data['og_info'] = ogInfo!.toJson();
    }
    if (misc != null) {
      data['misc'] = misc!.toJson();
    }
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
