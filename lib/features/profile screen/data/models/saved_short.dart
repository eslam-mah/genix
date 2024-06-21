import 'comment.dart';
import 'misc.dart';
import 'reactions.dart';
import 'revenue.dart';
import 'saves.dart';
import 'user.dart';

class SavedShort {
  int? id;
  User? user;
  String? content;
  bool? isVideoShort;
  bool? isProcessing;
  String? thumbnailUrl;
  String? fileUrl;
  int? viewsUnique;
  Reactions? reactions;
  List<Comment>? comments;
  int? commentsCount;
  int? sharesCount;
  Saves? saves;
  Revenue? revenue;
  Misc? misc;
  DateTime? createdAt;
  DateTime? updatedAt;

  SavedShort({
    this.id,
    this.user,
    this.content,
    this.isVideoShort,
    this.isProcessing,
    this.thumbnailUrl,
    this.fileUrl,
    this.viewsUnique,
    this.reactions,
    this.comments,
    this.commentsCount,
    this.sharesCount,
    this.saves,
    this.revenue,
    this.misc,
    this.createdAt,
    this.updatedAt,
  });

  SavedShort.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        content = json['content'],
        isVideoShort = json['is_video_short'],
        isProcessing = json['is_processing'],
        thumbnailUrl = json['thumbnail_url'],
        fileUrl = json['file_url'],
        viewsUnique = json['views_unique'],
        reactions = json['reactions'] != null
            ? Reactions.fromJson(json['reactions'])
            : null,
        comments = (json['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromJson(e))
            .toList(),
        commentsCount = json['comments_count'],
        sharesCount = json['shares_count'],
        saves = json['saves'] != null ? Saves.fromJson(json['saves']) : null,
        revenue =
            json['revenue'] != null ? Revenue.fromJson(json['revenue']) : null,
        misc = json['misc'] != null ? Misc.fromJson(json['misc']) : null,
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
    data['content'] = this.content;
    data['is_video_short'] = this.isVideoShort;
    data['is_processing'] = this.isProcessing;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['file_url'] = this.fileUrl;
    data['views_unique'] = this.viewsUnique;
    data['reactions'] = this.reactions?.toJson();
    data['comments'] = this.comments?.map((e) => e.toJson()).toList();
    data['comments_count'] = this.commentsCount;
    data['shares_count'] = this.sharesCount;
    data['saves'] = this.saves?.toJson();
    data['revenue'] = this.revenue?.toJson();
    data['misc'] = this.misc?.toJson();
    data['created_at'] = this.createdAt?.toString();
    data['updated_at'] = this.updatedAt?.toString();
    return data;
  }
}
