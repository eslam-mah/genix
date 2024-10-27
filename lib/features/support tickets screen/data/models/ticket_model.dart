class TicketItem {
  bool? success;
  TicketModel? data;
  String? message;

  TicketItem({this.success, this.data, this.message});

  factory TicketItem.fromJson(Map<String, dynamic> json) {
    return TicketItem(
      success: json['success'] as bool?,
      data: json['data'] != null ? TicketModel.fromJson(json['data']) : null,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class TicketModel {
  int? id;
  User? user;
  User? lastUser;
  String? title;
  String? content;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Comment>? comments;

  TicketModel({
    this.id,
    this.user,
    this.lastUser,
    this.title,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.comments,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as int?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      lastUser:
          json['last_user'] != null ? User.fromJson(json['last_user']) : null,
      title: json['title'] as String?,
      content: json['content'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      comments: json['comments'] != null
          ? (json['comments'] as List).map((c) => Comment.fromJson(c)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'last_user': lastUser?.toJson(),
      'title': title,
      'content': content,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'comments': comments?.map((c) => c.toJson()).toList(),
    };
  }
}

class User {
  int? id;
  String? username;
  String? showname;
  String? profileImg;
  String? coverImg;
  bool? isVerified;
  DateTime? createdAt;
  bool? isActive;
  int? status;

  User({
    this.id,
    this.username,
    this.showname,
    this.profileImg,
    this.coverImg,
    this.isVerified,
    this.createdAt,
    this.isActive,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      username: json['username'] as String?,
      showname: json['showname'] as String?,
      profileImg: json['profile_img'] as String?,
      coverImg: json['cover_img'] as String?,
      isVerified: json['is_verified'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      isActive: json['is_active'] as bool?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'showname': showname,
      'profile_img': profileImg,
      'cover_img': coverImg,
      'is_verified': isVerified,
      'created_at': createdAt?.toIso8601String(),
      'is_active': isActive,
      'status': status,
    };
  }
}

class Comment {
  int? id;
  User? user;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  Comment({
    this.id,
    this.user,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      content: json['content'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'content': content,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
