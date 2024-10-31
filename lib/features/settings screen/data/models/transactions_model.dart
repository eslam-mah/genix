class TransactionModel {
  int id;
  User user;
  String name;
  String mode;
  String status;
  int oldCoins;
  int newCoins;
  DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.user,
    required this.name,
    required this.mode,
    required this.status,
    required this.oldCoins,
    required this.newCoins,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? 0,
      user: User.fromJson(json['user']),
      name: json['name'] ?? '',
      mode: json['mode'] ?? '',
      status: json['status'] ?? '',
      oldCoins: json['old_coins'] ?? 0,
      newCoins: json['new_coins'] ?? 0,
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user'] = this.user.toJson();
    data['name'] = this.name;
    data['mode'] = this.mode;
    data['status'] = this.status;
    data['old_coins'] = this.oldCoins;
    data['new_coins'] = this.newCoins;
    data['created_at'] = this.createdAt.toIso8601String();
    return data;
  }
}

class User {
  int id;
  String username;
  String showname;
  String profileImg;
  String? coverImg;
  bool isVerified;
  DateTime createdAt;
  bool isActive;
  int status;

  User({
    required this.id,
    required this.username,
    required this.showname,
    required this.profileImg,
    this.coverImg,
    required this.isVerified,
    required this.createdAt,
    required this.isActive,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      showname: json['showname'] ?? '',
      profileImg: json['profile_img'] ?? '',
      coverImg: json['cover_img'],
      isVerified: json['is_verified'] ?? false,
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      isActive: json['is_active'] ?? true,
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
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt.toIso8601String();
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    return data;
  }
}
