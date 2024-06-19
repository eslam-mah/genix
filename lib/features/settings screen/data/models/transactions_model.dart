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
    final Map<String, dynamic> TransactionsModel = new Map<String, dynamic>();
    if (this.collection != null) {
      TransactionsModel['collection'] =
          this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      TransactionsModel['pagination'] = this.pagination!.toJson();
    }
    return TransactionsModel;
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
    final Map<String, dynamic> TransactionsModel = new Map<String, dynamic>();
    TransactionsModel['id'] = this.id;
    if (this.user != null) {
      TransactionsModel['user'] = this.user!.toJson();
    }
    TransactionsModel['name'] = this.name;
    TransactionsModel['mode'] = this.mode;
    TransactionsModel['status'] = this.status;
    TransactionsModel['old_coins'] = this.oldCoins;
    TransactionsModel['new_coins'] = this.newCoins;
    if (this.misc != null) {
      TransactionsModel['misc'] = this.misc!.toJson();
    }
    TransactionsModel['created_at'] = this.createdAt;
    return TransactionsModel;
  }
}

class User {
  int? id;
  String? username;
  String? showname;
  String? profileImg;
  Null? coverImg;
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
    final Map<String, dynamic> TransactionsModel = new Map<String, dynamic>();
    TransactionsModel['id'] = this.id;
    TransactionsModel['username'] = this.username;
    TransactionsModel['showname'] = this.showname;
    TransactionsModel['profile_img'] = this.profileImg;
    TransactionsModel['cover_img'] = this.coverImg;
    TransactionsModel['roles'] = this.roles;
    TransactionsModel['is_verified'] = this.isVerified;
    TransactionsModel['created_at'] = this.createdAt;
    TransactionsModel['is_active'] = this.isActive;
    TransactionsModel['status'] = this.status;
    TransactionsModel['active_at'] = this.activeAt;
    return TransactionsModel;
  }
}

class Misc {
  String? rate;

  Misc({this.rate});

  Misc.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> TransactionsModel = new Map<String, dynamic>();
    TransactionsModel['rate'] = this.rate;
    return TransactionsModel;
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
    final Map<String, dynamic> TransactionsModel = new Map<String, dynamic>();
    TransactionsModel['current_page'] = this.currentPage;
    TransactionsModel['from'] = this.from;
    TransactionsModel['last_page'] = this.lastPage;
    TransactionsModel['per_page'] = this.perPage;
    TransactionsModel['to'] = this.to;
    TransactionsModel['total'] = this.total;
    return TransactionsModel;
  }
}
