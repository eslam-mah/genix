class TicketsModel {
  List<Collection> collection;
  Pagination? pagination;
  int? totalCount;
  int? openCount;
  int? solvedCount;

  TicketsModel(
      {required this.collection,
      this.pagination,
      this.totalCount,
      this.openCount,
      this.solvedCount});

  TicketsModel.fromJson(Map<String, dynamic> json)
      : collection = (json['collection'] as List)
            .map((v) => Collection.fromJson(v))
            .toList(),
        pagination = json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null,
        totalCount = json['totalCount'],
        openCount = json['openCount'],
        solvedCount = json['solvedCount'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> TicketsModel = new Map<String, dynamic>();

    TicketsModel['collection'] =
        this.collection.map((v) => v.toJson()).toList();

    if (this.pagination != null) {
      TicketsModel['pagination'] = this.pagination!.toJson();
    }
    TicketsModel['totalCount'] = this.totalCount;
    TicketsModel['openCount'] = this.openCount;
    TicketsModel['solvedCount'] = this.solvedCount;
    return TicketsModel;
  }
}

class Collection {
  int id;
  User? user;
  LastUser? lastUser;
  String? title;
  String? content;
  String? status;
  String? createdAt;
  String? updatedAt;

  Collection(
      {required this.id,
      this.user,
      this.lastUser,
      this.title,
      this.content,
      this.status,
      this.createdAt,
      this.updatedAt});

  Collection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? new User.fromJson(json['user']) : null,
        lastUser = json['last_user'] != null
            ? new LastUser.fromJson(json['last_user'])
            : null,
        title = json['title'],
        content = json['content'],
        status = json['status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> TicketsModel = new Map<String, dynamic>();
    TicketsModel['id'] = this.id;
    if (this.user != null) {
      TicketsModel['user'] = this.user!.toJson();
    }
    if (this.lastUser != null) {
      TicketsModel['last_user'] = this.lastUser!.toJson();
    }
    TicketsModel['title'] = this.title;
    TicketsModel['content'] = this.content;
    TicketsModel['status'] = this.status;
    TicketsModel['created_at'] = this.createdAt;
    TicketsModel['updated_at'] = this.updatedAt;
    return TicketsModel;
  }
}

class User {
  int? id;
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

  User(
      {this.id,
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

  User.fromJson(Map<String, dynamic> json)
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
    final Map<String, dynamic> TicketsModel = new Map<String, dynamic>();
    TicketsModel['id'] = this.id;
    TicketsModel['username'] = this.username;
    TicketsModel['showname'] = this.showname;
    TicketsModel['profile_img'] = this.profileImg;
    TicketsModel['cover_img'] = this.coverImg;
    TicketsModel['roles'] = this.roles;
    TicketsModel['is_verified'] = this.isVerified;
    TicketsModel['created_at'] = this.createdAt;
    TicketsModel['is_active'] = this.isActive;
    TicketsModel['status'] = this.status;
    TicketsModel['active_at'] = this.activeAt;
    return TicketsModel;
  }
}

class LastUser {
  int? id;
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

  LastUser(
      {this.id,
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

  LastUser.fromJson(Map<String, dynamic> json)
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
    final Map<String, dynamic> TicketsModel = new Map<String, dynamic>();
    TicketsModel['id'] = this.id;
    TicketsModel['username'] = this.username;
    TicketsModel['showname'] = this.showname;
    TicketsModel['profile_img'] = this.profileImg;
    TicketsModel['cover_img'] = this.coverImg;
    TicketsModel['roles'] = this.roles;
    TicketsModel['is_verified'] = this.isVerified;
    TicketsModel['created_at'] = this.createdAt;
    TicketsModel['is_active'] = this.isActive;
    TicketsModel['status'] = this.status;
    TicketsModel['active_at'] = this.activeAt;
    return TicketsModel;
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
    final Map<String, dynamic> TicketsModel = new Map<String, dynamic>();
    TicketsModel['current_page'] = this.currentPage;
    TicketsModel['from'] = this.from;
    TicketsModel['last_page'] = this.lastPage;
    TicketsModel['per_page'] = this.perPage;
    TicketsModel['to'] = this.to;
    TicketsModel['total'] = this.total;
    return TicketsModel;
  }
}
