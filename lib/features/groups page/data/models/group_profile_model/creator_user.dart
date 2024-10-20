class CreatorUser {
  int? id;
  String? username;
  String? showname;
  String? profileImg;
  String? coverImg;
  bool? isVerified;
  DateTime? createdAt;
  bool? isActive;

  CreatorUser({
    this.id,
    this.username,
    this.showname,
    this.profileImg,
    this.coverImg,
    this.isVerified,
    this.createdAt,
    this.isActive,
  });

  factory CreatorUser.fromJson(Map<String, dynamic> json) => CreatorUser(
        id: json['id'] as int?,
        username: json['username'] as String?,
        showname: json['showname'] as String?,
        profileImg: json['profile_img'] as String?,
        coverImg: json['cover_img'] as String?,
        isVerified: json['is_verified'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        isActive: json['is_active'] as bool?,
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
      };
}
