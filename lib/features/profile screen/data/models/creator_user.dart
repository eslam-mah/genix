class CreatorUser {
  int? id;
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

  CreatorUser({
    this.id,
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

  CreatorUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        showname = json['showname'],
        profileImg = json['profile_img'],
        coverImg = json['cover_img'],
        roles = json['roles']?.cast<String>(),
        isVerified = json['is_verified'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        isActive = json['is_active'],
        status = json['status'],
        activeAt = json['active_at'] != null
            ? DateTime.parse(json['active_at'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['roles'] = this.roles;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt?.toString();
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    data['active_at'] = this.activeAt?.toString();
    return data;
  }
}
