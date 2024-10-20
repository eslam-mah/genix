import 'package:equatable/equatable.dart';
import 'package:genix/features/profile%20screen/data/profile_model/misc.dart';
import 'package:genix/features/profile%20screen/data/profile_model/uploads.dart';

import 'og_info.dart';
import 'user.dart';

class RecentPost extends Equatable {
  final int? id;
  final User? user;
  final dynamic page;
  final dynamic group;
  final String? content;
  final bool? inNewsfeed;
  final bool? inStory;
  final bool? isVideoShort;
  final bool? isEvent;
  final bool? toCloseFriends;
  final bool? isProcessing;
  final List<Upload>? uploads;
  // final Reactions? reactions;
  final List<dynamic>? comments;
  final int? commentsCount;
  final int? sharesCount;
  final OgInfo? ogInfo;
  final Misc? misc;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const RecentPost({
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
    // this.reactions,
    this.comments,
    this.commentsCount,
    this.sharesCount,
    this.ogInfo,
    this.misc,
    this.createdAt,
    this.updatedAt,
  });

  factory RecentPost.fromJson(Map<String, dynamic> json) => RecentPost(
        id: json['id'] as int?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        page: json['page'] as dynamic,
        group: json['group'] as dynamic,
        content: json['content'] as String?,
        inNewsfeed: json['in_newsfeed'] as bool?,
        inStory: json['in_story'] as bool?,
        isVideoShort: json['is_video_short'] as bool?,
        isEvent: json['is_event'] as bool?,
        toCloseFriends: json['to_close_friends'] as bool?,
        isProcessing: json['is_processing'] as bool?,
        uploads: json['uploads'] != null
            ? (json['uploads'] as List<dynamic>)
                .map((v) => Upload.fromJson(v as Map<String, dynamic>))
                .toList()
            : null,
        // reactions: json['reactions'] == null
        //     ? null
        //     : Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
        comments: json['comments'] as List<dynamic>?,
        commentsCount: json['comments_count'] as int?,
        sharesCount: json['shares_count'] as int?,
        ogInfo: json['og_info'] == null
            ? null
            : OgInfo.fromJson(json['og_info'] as Map<String, dynamic>),
        misc: json['misc'] is Map<String, dynamic> && json['misc'] != null
            ? Misc.fromJson(json['misc'] as Map<String, dynamic>)
            : null,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'page': page,
        'group': group,
        'content': content,
        'in_newsfeed': inNewsfeed,
        'in_story': inStory,
        'is_video_short': isVideoShort,
        'is_event': isEvent,
        'to_close_friends': toCloseFriends,
        'is_processing': isProcessing,
        'uploads': uploads?.map((v) => v.toJson()).toList(),
        // 'reactions': reactions?.toJson(),
        'comments': comments,
        'comments_count': commentsCount,
        'shares_count': sharesCount,
        'og_info': ogInfo?.toJson(),
        'misc': misc?.toJson(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      user,
      page,
      group,
      content,
      inNewsfeed,
      inStory,
      isVideoShort,
      isEvent,
      toCloseFriends,
      isProcessing,
      uploads,
      // reactions,
      comments,
      commentsCount,
      sharesCount,
      ogInfo,
      misc,
      createdAt,
      updatedAt,
    ];
  }
}
