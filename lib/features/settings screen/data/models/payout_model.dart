class PayoutModel {
  Payout? payout;
  User? user;

  PayoutModel({this.payout, this.user});

  PayoutModel.fromJson(Map<String, dynamic> json) {
    payout =
        json['payout'] != null ? new Payout.fromJson(json['payout']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> PayoutModel = new Map<String, dynamic>();
    if (this.payout != null) {
      PayoutModel['payout'] = this.payout!.toJson();
    }
    if (this.user != null) {
      PayoutModel['user'] = this.user!.toJson();
    }
    return PayoutModel;
  }
}

class Payout {
  int? id;
  User? user;
  String? name;
  String? mode;
  String? status;
  int? oldCoins;
  int? newCoins;
  Misc? misc;
  String? createdAt;

  Payout(
      {this.id,
      this.user,
      this.name,
      this.mode,
      this.status,
      this.oldCoins,
      this.newCoins,
      this.misc,
      this.createdAt});

  Payout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    name = json['name'];
    mode = json['mode'];
    status = json['status'];
    oldCoins = json['old_coins'];
    newCoins = json['new_coins'];
    misc = json['misc'] != null ? new Misc.fromJson(json['misc']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> PayoutModel = new Map<String, dynamic>();
    PayoutModel['id'] = this.id;
    if (this.user != null) {
      PayoutModel['user'] = this.user!.toJson();
    }
    PayoutModel['name'] = this.name;
    PayoutModel['mode'] = this.mode;
    PayoutModel['status'] = this.status;
    PayoutModel['old_coins'] = this.oldCoins;
    PayoutModel['new_coins'] = this.newCoins;
    if (this.misc != null) {
      PayoutModel['misc'] = this.misc!.toJson();
    }
    PayoutModel['created_at'] = this.createdAt;
    return PayoutModel;
  }
}

class Misc {
  int? coins;
  double? totalRevenue;
  String? feePercent;
  double? fee;
  double? finalRevenue;

  Misc(
      {this.coins,
      this.totalRevenue,
      this.feePercent,
      this.fee,
      this.finalRevenue});

  Misc.fromJson(Map<String, dynamic> json) {
    coins = json['coins'];
    totalRevenue = json['total_revenue'];
    feePercent = json['fee_percent'];
    fee = json['fee'];
    finalRevenue = json['final_revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> PayoutModel = new Map<String, dynamic>();
    PayoutModel['coins'] = this.coins;
    PayoutModel['total_revenue'] = this.totalRevenue;
    PayoutModel['fee_percent'] = this.feePercent;
    PayoutModel['fee'] = this.fee;
    PayoutModel['final_revenue'] = this.finalRevenue;
    return PayoutModel;
  }
}

class User {
  int? id;
  String? username;
  String? showname;
  int? coins;
  int? revenueCoins;
  int? revenue;
  String? profileImg;
  String? coverImg;

  User(
      {this.id,
      this.username,
      this.showname,
      this.coins,
      this.revenueCoins,
      this.revenue,
      this.profileImg,
      this.coverImg});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    showname = json['showname'];
    coins = json['coins'];
    revenueCoins = json['revenue_coins'];
    revenue = json['revenue'];
    profileImg = json['profile_img'];
    coverImg = json['cover_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> PayoutModel = new Map<String, dynamic>();
    PayoutModel['id'] = this.id;
    PayoutModel['username'] = this.username;
    PayoutModel['showname'] = this.showname;
    PayoutModel['coins'] = this.coins;
    PayoutModel['revenue_coins'] = this.revenueCoins;
    PayoutModel['revenue'] = this.revenue;
    PayoutModel['profile_img'] = this.profileImg;
    PayoutModel['cover_img'] = this.coverImg;
    return PayoutModel;
  }
}
