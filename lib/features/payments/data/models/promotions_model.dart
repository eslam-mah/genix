import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

class PromotionsModel {
  int id;
  UserModel user;
  PostsModel post;
  int allocatedCoins;
  int remainingCoins;
  int cpvRate;
  DateTime createdAt;

  PromotionsModel({
    required this.id,
    required this.user,
    required this.post,
    required this.allocatedCoins,
    required this.remainingCoins,
    required this.cpvRate,
    required this.createdAt,
  });

  factory PromotionsModel.fromJson(Map<String, dynamic> json) {
    return PromotionsModel(
      id: json['id'] ?? 0,
      user: UserModel.fromJson(json['user'] ?? {}),
      post: PostsModel.fromJson(json['post'] ?? {}),
      allocatedCoins: json['allocated_coins'] ?? 0,
      remainingCoins: json['remaining_coins'] ?? 0,
      cpvRate: json['cpv_rate'] ?? 0,
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user'] = this.user.toJson();
    data['post'] = this.post.toJson();
    data['allocated_coins'] = this.allocatedCoins;
    data['remaining_coins'] = this.remainingCoins;
    data['cpv_rate'] = this.cpvRate;
    data['created_at'] = this.createdAt.toIso8601String();
    return data;
  }
}

class UserModel {
  int id;
  String username;
  String showName;
  String profileImg;
  String coverImg;
  bool isVerified;
  DateTime createdAt;
  bool isActive;

  UserModel({
    required this.id,
    required this.username,
    required this.showName,
    required this.profileImg,
    required this.coverImg,
    required this.isVerified,
    required this.createdAt,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      showName: json['showname'] ?? '',
      profileImg: json['profile_img'] ?? '',
      coverImg: json['cover_img'] ?? '',
      isVerified: json['is_verified'] ?? false,
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showName;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt.toIso8601String();
    data['is_active'] = this.isActive;
    return data;
  }
}
