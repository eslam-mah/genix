class TransactionsModel {
  List<Collection> collection;
  Pagination? pagination;

  TransactionsModel({required this.collection, this.pagination});
  TransactionsModel.fromJson(Map<String, dynamic> json)
      : collection = json['collection'](json['collection'] as List)
            .map((v) => Collection.fromJson(v))
            .toList(),
        pagination = json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Collection {
  int id;
  User? user;
  String? name;
  String? mode;
  String? status;
  int? oldCoins;
  int? newCoins;
  Misc? misc;
  String? createdAt;

  Collection(
      {required this.id,
      this.user,
      this.name,
      this.mode,
      this.status,
      this.oldCoins,
      this.newCoins,
      this.misc,
      this.createdAt});

  Collection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? new User.fromJson(json['user']) : null,
        name = json['name'],
        mode = json['mode'],
        status = json['status'],
        oldCoins = json['old_coins'],
        newCoins = json['new_coins'],
        misc = json['misc'] != null ? new Misc.fromJson(json['misc']) : null,
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['name'] = this.name;
    data['mode'] = this.mode;
    data['status'] = this.status;
    data['old_coins'] = this.oldCoins;
    data['new_coins'] = this.newCoins;
    if (this.misc != null) {
      data['misc'] = this.misc!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    showname = json['showname'];
    profileImg = json['profile_img'];
    coverImg = json['cover_img'];
    roles = json['roles'].cast<String>();
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    isActive = json['is_active'];
    status = json['status'];
    activeAt = json['active_at'];
  }

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

class Misc {
  String? rate;

  Misc({this.rate});

  Misc.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
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

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

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
