class FollowersModel {
  int id;
  UserModel user;
  bool isClose;

  FollowersModel({
    required this.id,
    required this.user,
    required this.isClose,
  });

  factory FollowersModel.fromJson(Map<String, dynamic> json) {
    return FollowersModel(
      id: json['id'] ?? 0,
      user: UserModel.fromJson(json['user'] ?? {}),
      isClose: json['is_close'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user'] = this.user.toJson();
    data['is_close'] = this.isClose;
    return data;
  }
}

class UserModel {
  int id;
  String username;
  String showname;
  String profileImg;
  String? coverImg;
  String bio;
  bool isVerified;
  String createdAt;
  bool isActive;
  int? status;

  UserModel({
    required this.id,
    required this.username,
    required this.showname,
    required this.profileImg,
    this.coverImg,
    required this.bio,
    required this.isVerified,
    required this.createdAt,
    required this.isActive,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      showname: json['showname'] ?? '',
      profileImg: json['profile_img'] ?? '',
      coverImg: json['cover_img'] ?? '',
      bio: json['bio'] ?? '',
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] ?? '',
      isActive: json['is_active'] ?? false,
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['bio'] = this.bio;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    return data;
  }
}
