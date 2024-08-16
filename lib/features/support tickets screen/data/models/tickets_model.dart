class TicketsModel {
  int id;
  User user;
  User lastUser;
  String title;
  String content;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  TicketsModel({
    required this.id,
    required this.user,
    required this.lastUser,
    required this.title,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TicketsModel.fromJson(Map<String, dynamic> json) {
    return TicketsModel(
      id: json['id'],
      user: User.fromJson(json['user']),
      lastUser: User.fromJson(json['last_user']),
      title: json['title'],
      content: json['content'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user'] = this.user.toJson();
    data['last_user'] = this.lastUser.toJson();
    data['title'] = this.title;
    data['content'] = this.content;
    data['status'] = this.status;
    data['created_at'] = this.createdAt.toIso8601String();
    data['updated_at'] = this.updatedAt.toIso8601String();
    return data;
  }
}

class User {
  int id;
  String username;
  String showname;
  String profileImg;
  String? coverImg;
  List<String> roles;
  bool isVerified;
  DateTime createdAt;
  bool isActive;
  int status;
  DateTime activeAt;

  User({
    required this.id,
    required this.username,
    required this.showname,
    required this.profileImg,
    this.coverImg,
    required this.roles,
    required this.isVerified,
    required this.createdAt,
    required this.isActive,
    required this.status,
    required this.activeAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      showname: json['showname'],
      profileImg: json['profile_img'],
      coverImg: json['cover_img'],
      roles: List<String>.from(json['roles']),
      isVerified: json['is_verified'],
      createdAt: DateTime.parse(json['created_at']),
      isActive: json['is_active'],
      status: json['status'],
      activeAt: DateTime.parse(json['active_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['roles'] = this.roles;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt.toIso8601String();
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    data['active_at'] = this.activeAt.toIso8601String();
    return data;
  }
}

class Pagination {
  int currentPage;
  int from;
  int lastPage;
  int perPage;
  int to;
  int total;

  Pagination({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
