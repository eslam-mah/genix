import 'package:genix/features/home%20screen/data/models/posts_model/summary.dart';

class ShortsModel {
  int id;
  UserModel? user;
  String? content;
  bool? isVideoShort;
  bool? isProcessing;
  String? thumbnailUrl;
  String? fileUrl;
  int? viewsUnique;
  Reactions? reactions;
  List<CommentsModel>? comments;
  int? commentsCount;
  int? sharesCount;
  SavesModel? saves;
  RevenueModel? revenue;
  MiscModel? misc;
  String? createdAt;
  String? updatedAt;

  ShortsModel({
    required this.id,
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

  ShortsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? UserModel.fromJson(json['user']) : null,
        content = json['content'],
        isVideoShort = json['is_video_short'],
        isProcessing = json['is_processing'],
        thumbnailUrl = json['thumbnail_url'],
        fileUrl = json['file_url'],
        viewsUnique = json['views_unique'],
        reactions = json['reactions'] != null &&
                json['reactions'] is Map<String, dynamic>
            ? Reactions.fromJson(json['reactions'] as Map<String, dynamic>)
            : null,
        comments = json['comments'] != null
            ? (json['comments'] as List)
                .map((e) => CommentsModel.fromJson(e))
                .toList()
            : null,
        commentsCount = json['comments_count'],
        sharesCount = json['shares_count'],
        saves =
            json['saves'] != null ? SavesModel.fromJson(json['saves']) : null,
        revenue = json['revenue'] != null
            ? RevenueModel.fromJson(json['revenue'])
            : null,
        misc = json['misc'] != null ? MiscModel.fromJson(json['misc']) : null,
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['content'] = content;
    data['is_video_short'] = isVideoShort;
    data['is_processing'] = isProcessing;
    data['thumbnail_url'] = thumbnailUrl;
    data['file_url'] = fileUrl;
    data['views_unique'] = viewsUnique;
    if (reactions != null) {
      data['reactions'] = reactions!.toJson();
    }
    if (comments != null) {
      data['comments'] = comments!.map((e) => e.toJson()).toList();
    }
    data['comments_count'] = commentsCount;
    data['shares_count'] = sharesCount;
    if (saves != null) {
      data['saves'] = saves!.toJson();
    }
    if (revenue != null) {
      data['revenue'] = revenue!.toJson();
    }
    if (misc != null) {
      data['misc'] = misc!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserModel {
  int id;
  String? username;
  String? showname;
  String? profileImg;
  String? coverImg;
  List<String>? roles;
  bool? isVerified;
  String? createdAt;
  bool? isActive;
  int? status;
  String? activeAt;

  UserModel({
    required this.id,
    this.username,
    this.showname,
    this.profileImg,
    this.coverImg,
    this.roles,
    this.isVerified,
    this.createdAt,
    this.isActive,
    this.status,
    this.activeAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        showname = json['showname'],
        profileImg = json['profile_img'],
        coverImg = json['cover_img'],
        roles = json['roles'],
        isVerified = json['is_verified'],
        createdAt = json['created_at'],
        isActive = json['is_active'],
        status = json['status'],
        activeAt = json['active_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['showname'] = showname;
    data['profile_img'] = profileImg;
    data['cover_img'] = coverImg;
    data['roles'] = roles;
    data['is_verified'] = isVerified;
    data['created_at'] = createdAt;
    data['is_active'] = isActive;
    data['status'] = status;
    data['active_at'] = activeAt;
    return data;
  }
}

class Reactions {
  Summary? summary;
  bool? byMe;

  Reactions({this.summary, this.byMe});

  Reactions.fromJson(Map<String, dynamic> json)
      : summary =
            json['summary'] != null && json['summary'] is Map<String, dynamic>
                ? Summary.fromJson(json['summary'] as Map<String, dynamic>)
                : null,
        byMe = json['by_me'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    data['by_me'] = byMe;
    return data;
  }
}

class CommentsModel {
  int id;
  UserModel? user;
  int? postId;
  int? commentId;
  String? content;
  Reactions? reactions;
  String? createdAt;

  CommentsModel({
    required this.id,
    this.user,
    this.postId,
    this.commentId,
    this.content,
    this.reactions,
    this.createdAt,
  });

  CommentsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? UserModel.fromJson(json['user']) : null,
        postId = json['post_id'],
        commentId = json['comment_id'],
        content = json['content'],
        reactions = json['reactions'] != null &&
                json['reactions'] is Map<String, dynamic>
            ? Reactions.fromJson(json['reactions'] as Map<String, dynamic>)
            : null,
        createdAt = json['created_at'];

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

class SavesModel {
  int? count;
  bool? byMe;

  SavesModel({this.count, this.byMe});

  SavesModel.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        byMe = json['by_me'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['by_me'] = byMe;
    return data;
  }
}

class RevenueModel {
  int? total;
  List<TopModel>? top;

  RevenueModel({this.total, this.top});

  RevenueModel.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        top = json['top'] != null
            ? (json['top'] as List).map((e) => TopModel.fromJson(e)).toList()
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (top != null) {
      data['top'] = top!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class TopModel {
  int? total;
  UserModel? user;

  TopModel({this.total, this.user});

  TopModel.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        user = json['user'] != null ? UserModel.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class MiscModel {
  String? orientation;

  MiscModel({this.orientation});

  MiscModel.fromJson(Map<String, dynamic> json)
      : orientation = json['orientation'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orientation'] = orientation;
    return data;
  }
}

class PaginationModel {
  int currentPage;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  PaginationModel({
    required this.currentPage,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  PaginationModel.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        from = json['from'],
        lastPage = json['last_page'],
        perPage = json['per_page'],
        to = json['to'],
        total = json['total'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}
