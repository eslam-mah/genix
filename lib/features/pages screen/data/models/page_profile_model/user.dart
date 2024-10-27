class User {
  int? id;
  String? username;
  String? showname;
  String? profileImg;
  dynamic coverImg;
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

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        username: json['username'] as String?,
        showname: json['showname'] as String?,
        profileImg: json['profile_img'] as String?,
        coverImg: json['cover_img'] as dynamic,
        isVerified: json['is_verified'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        isActive: json['is_active'] as bool?,
        status: json['status'] as int?,
      );

  Map<String, dynamic> toJson() => {
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
