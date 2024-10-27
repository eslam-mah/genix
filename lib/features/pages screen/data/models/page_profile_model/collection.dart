import 'package:genix/features/groups%20page/data/models/group_profile_model/group.dart';

import 'page.dart';
import 'misc.dart';
import 'reactions.dart';
import 'user.dart';

class Collection {
  int? id;
  User? user;
  Group? group;
  Page? page;
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
  Misc? misc;
  DateTime? createdAt;

  Collection({
    this.id,
    this.user,
    this.group,
    this.page,
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
    this.misc,
    this.createdAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json['id'] as int?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        group: json['group'] == null
            ? null
            : Group.fromJson(json['group'] as Map<String, dynamic>),
        page: json['page'] == null
            ? null
            : Page.fromJson(json['page'] as Map<String, dynamic>),
        content: json['content'] as String?,
        inNewsfeed: json['in_newsfeed'] as bool?,
        inStory: json['in_story'] as bool?,
        isVideoShort: json['is_video_short'] as bool?,
        isEvent: json['is_event'] as bool?,
        toCloseFriends: json['to_close_friends'] as bool?,
        isProcessing: json['is_processing'] as bool?,
        uploads: json['uploads'] as List<dynamic>?,
        reactions: json['reactions'] == null
            ? null
            : Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
        comments: json['comments'] as List<dynamic>?,
        commentsCount: json['comments_count'] as int?,
        sharesCount: json['shares_count'] as int?,
        misc: json['misc'] == null
            ? null
            : Misc.fromJson(json['misc'] as Map<String, dynamic>),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'group': group?.toJson(),
        'page': page?.toJson(),
        'content': content,
        'in_newsfeed': inNewsfeed,
        'in_story': inStory,
        'is_video_short': isVideoShort,
        'is_event': isEvent,
        'to_close_friends': toCloseFriends,
        'is_processing': isProcessing,
        'uploads': uploads,
        'reactions': reactions?.toJson(),
        'comments': comments,
        'comments_count': commentsCount,
        'shares_count': sharesCount,
        'misc': misc?.toJson(),
        'created_at': createdAt?.toIso8601String(),
      };
}
