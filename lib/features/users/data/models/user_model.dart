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

  UserModel(
      {required this.id,
      this.username,
      this.showname,
      this.profileImg,
      this.coverImg,
      this.roles,
      this.isVerified,
      this.createdAt,
      this.isActive,
      this.status,
      this.activeAt});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        showname = json['showname'],
        profileImg = json['profile_img'],
        coverImg = json['cover_img'],
        roles = json['roles'].cast<String>(),
        isVerified = json['is_verified'],
        createdAt = json['created_at'],
        isActive = json['is_active'],
        status = json['status'],
        activeAt = json['active_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['roles'] = this.roles;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    data['active_at'] = this.activeAt;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  Pagination(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.perPage,
      this.to,
      this.total});

  Pagination.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        from = json['from'],
        lastPage = json['last_page'],
        perPage = json['per_page'],
        to = json['to'],
        total = json['total'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
