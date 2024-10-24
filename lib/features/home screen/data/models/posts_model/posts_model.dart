import 'package:genix/features/comments%20section/data/models/comments_model.dart';
import 'package:genix/features/groups%20page/data/models/groups_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/misc.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/uploads.dart';
import 'package:genix/features/pages%20screen/data/models/pages_model.dart';

import 'og_info.dart';
import 'reactions.dart';
import 'user.dart';

class PostsModel {
  num? id;
  User? user;
  PagesModel? page;
  GroupsModel? group;
  String? content;
  PostsModel? sharedPost;
  bool? inNewsfeed;
  bool? inStory;
  bool? isVideoShort;
  bool? isEvent;
  bool? toCloseFriends;
  bool? isProcessing;
  List<Upload>? uploads;
  Reactions? reactions;
  List<Comment>? comments;
  num? commentsCount;
  num? sharesCount;
  OgInfo? ogInfo;
  Misc? misc;
  DateTime? createdAt;
  DateTime? updatedAt;

  PostsModel({
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

  PostsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] != null && json['id'] is num ? json['id'] as num : null,
        sharedPost = json['shared_post'] != null &&
                json['shared_post'] is Map<String, dynamic>
            ? PostsModel.fromJson(json['shared_post'] as Map<String, dynamic>)
            : null,
        user = json['user'] != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        page = json['page'] != null && json['page'] is Map<String, dynamic>
            ? PagesModel.fromJson(json['page'] as Map<String, dynamic>)
            : null,
        group = json['group'] != null && json['group'] is Map<String, dynamic>
            ? GroupsModel.fromJson(json['group'] as Map<String, dynamic>)
            : null,
        content = json['content'] != null && json['content'] is String
            ? json['content'] as String?
            : null,
        inNewsfeed = json['in_newsfeed'] != null && json['in_newsfeed'] is bool
            ? json['in_newsfeed'] as bool?
            : null,
        inStory = json['in_story'] != null && json['in_story'] is bool
            ? json['in_story'] as bool?
            : null,
        isVideoShort =
            json['is_video_short'] != null && json['is_video_short'] is bool
                ? json['is_video_short'] as bool?
                : null,
        isEvent = json['is_event'] != null && json['is_event'] is bool
            ? json['is_event'] as bool?
            : null,
        toCloseFriends = json['to_close_friends'] as bool?,
        isProcessing = json['is_processing'] as bool?,
        uploads = json['uploads'] != null && json['uploads'] is List<dynamic>
            ? (json['uploads'] as List<dynamic>)
                .map((v) => Upload.fromJson(v as Map<String, dynamic>))
                .toList()
            : null,
        reactions = json['reactions'] != null &&
                json['reactions'] is Map<String, dynamic>
            ? Reactions.fromJson(json['reactions'] as Map<String, dynamic>)
            : null,
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
