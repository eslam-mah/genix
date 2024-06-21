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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payout != null) {
      data['payout'] = this.payout!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coins'] = this.coins;
    data['total_revenue'] = this.totalRevenue;
    data['fee_percent'] = this.feePercent;
    data['fee'] = this.fee;
    data['final_revenue'] = this.finalRevenue;
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['coins'] = this.coins;
    data['revenue_coins'] = this.revenueCoins;
    data['revenue'] = this.revenue;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    return data;
  }
}
