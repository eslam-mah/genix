class User {
  int id;
  String? username;
  String? showname;
  String? profileImg;
  String? coverImg;
  List<String>? roles;
  bool? isVerified;
  DateTime? createdAt;
  bool? isActive;
  int? status;
  DateTime? activeAt;

  User({
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

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        username = json['username'] as String?,
        showname = json['showname'] as String?,
        profileImg = json['profile_img'] as String?,
        coverImg = json['cover_img'] as String?,
        roles = (json['roles'] as List<dynamic>?)?.cast<String>(),
        isVerified = json['is_verified'] as bool?,
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        isActive = json['is_active'] as bool?,
        status = json['status'] as int?,
        activeAt = json['active_at'] != null
            ? DateTime.parse(json['active_at'] as String)
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['showname'] = showname;
    data['profile_img'] = profileImg;
    data['cover_img'] = coverImg;
    data['roles'] = roles;
    data['is_verified'] = isVerified;
    data['created_at'] = createdAt?.toString();
    data['is_active'] = isActive;
    data['status'] = status;
    data['active_at'] = activeAt?.toString();
    return data;
  }
}
