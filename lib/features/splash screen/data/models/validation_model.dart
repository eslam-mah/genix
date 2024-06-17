class ValidationModel {
  Settings? settings;
  User? user;
  List<CustomEmoji>? customEmoji;

  ValidationModel({this.settings, this.user, this.customEmoji});

  ValidationModel.fromJson(Map<String, dynamic> json) {
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['custom_emoji'] != null) {
      customEmoji = <CustomEmoji>[];
      json['custom_emoji'].forEach((v) {
        customEmoji!.add(CustomEmoji.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (customEmoji != null) {
      data['custom_emoji'] = customEmoji!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  String? realCurrency;
  String? realCurrencyCode;
  List<int>? stripeDefaultCoinsValues;
  String? coinsCurrencyRate;
  String? payoutFeeRate;
  int? payoutMinLimit;
  List<int>? promotionDefaultCoinsValues;
  bool? maintenanceEnabled;

  Settings({
    this.realCurrency,
    this.realCurrencyCode,
    this.stripeDefaultCoinsValues,
    this.coinsCurrencyRate,
    this.payoutFeeRate,
    this.payoutMinLimit,
    this.promotionDefaultCoinsValues,
    this.maintenanceEnabled,
  });

  Settings.fromJson(Map<String, dynamic> json) {
    realCurrency = json['real_currency'];
    realCurrencyCode = json['real_currency_code'];
    stripeDefaultCoinsValues =
        List<int>.from(json['stripe_default_coins_values']);
    coinsCurrencyRate = json['coins_currency_rate'];
    payoutFeeRate = json['payout_fee_rate'];
    payoutMinLimit = json['payout_min_limit'];
    promotionDefaultCoinsValues =
        List<int>.from(json['promotion_default_coins_values']);
    maintenanceEnabled = json['maintenance_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['real_currency'] = realCurrency;
    data['real_currency_code'] = realCurrencyCode;
    data['stripe_default_coins_values'] = stripeDefaultCoinsValues;
    data['coins_currency_rate'] = coinsCurrencyRate;
    data['payout_fee_rate'] = payoutFeeRate;
    data['payout_min_limit'] = payoutMinLimit;
    data['promotion_default_coins_values'] = promotionDefaultCoinsValues;
    data['maintenance_enabled'] = maintenanceEnabled;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? showname;
  String? email;
  int? coins;
  int? revenueCoins;
  double? revenue;
  bool? allowFollowers;
  bool? allowNotifications;
  bool? allowTags;
  bool? allowSearchEngines;
  bool? allowEmails;
  String? dateOfBirth;
  String? paypalEmail;
  String? profileImg;
  String? coverImg;
  String? gender;
  String? bio;
  String? country;
  String? city;
  String? age;
  String? socialFacebook;
  String? socialTiktok;
  String? socialInstagram;
  String? socialTwitter;
  String? socialSteam;
  String? socialPinterest;
  String? socialLinkedin;
  List<String>? roles;
  List<String>? permissions;
  bool? verified;
  bool? tfaEnabled;
  bool? isVerified;
  String? createdAt;
  bool? isActive;
  int? status;
  String? activeAt;

  User({
    this.id,
    this.username,
    this.showname,
    this.email,
    this.coins,
    this.revenueCoins,
    this.revenue,
    this.allowFollowers,
    this.allowNotifications,
    this.allowTags,
    this.allowSearchEngines,
    this.allowEmails,
    this.dateOfBirth,
    this.paypalEmail,
    this.profileImg,
    this.coverImg,
    this.gender,
    this.bio,
    this.country,
    this.city,
    this.age,
    this.socialFacebook,
    this.socialTiktok,
    this.socialInstagram,
    this.socialTwitter,
    this.socialSteam,
    this.socialPinterest,
    this.socialLinkedin,
    this.roles,
    this.permissions,
    this.verified,
    this.tfaEnabled,
    this.isVerified,
    this.createdAt,
    this.isActive,
    this.status,
    this.activeAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    showname = json['showname'];
    email = json['email'];
    coins = json['coins'];
    revenueCoins = json['revenue_coins'];
    revenue = json['revenue'];
    allowFollowers = json['allow_followers'];
    allowNotifications = json['allow_notifications'];
    allowTags = json['allow_tags'];
    allowSearchEngines = json['allow_search_engines'];
    allowEmails = json['allow_emails'];
    dateOfBirth = json['date_of_birth'];
    paypalEmail = json['paypal_email'];
    profileImg = json['profile_img'];
    coverImg = json['cover_img'];
    gender = json['gender'];
    bio = json['bio'];
    country = json['country'];
    city = json['city'];
    age = json['age'];
    socialFacebook = json['social_facebook'];
    socialTiktok = json['social_tiktok'];
    socialInstagram = json['social_instagram'];
    socialTwitter = json['social_twitter'];
    socialSteam = json['social_steam'];
    socialPinterest = json['social_pinterest'];
    socialLinkedin = json['social_linkedin'];
    roles = List<String>.from(json['roles']);
    permissions = List<String>.from(json['permissions']);
    verified = json['verified'];
    tfaEnabled = json['tfa_enabled'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    isActive = json['is_active'];
    status = json['status'];
    activeAt = json['active_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['showname'] = showname;
    data['email'] = email;
    data['coins'] = coins;
    data['revenue_coins'] = revenueCoins;
    data['revenue'] = revenue;
    data['allow_followers'] = allowFollowers;
    data['allow_notifications'] = allowNotifications;
    data['allow_tags'] = allowTags;
    data['allow_search_engines'] = allowSearchEngines;
    data['allow_emails'] = allowEmails;
    data['date_of_birth'] = dateOfBirth;
    data['paypal_email'] = paypalEmail;
    data['profile_img'] = profileImg;
    data['cover_img'] = coverImg;
    data['gender'] = gender;
    data['bio'] = bio;
    data['country'] = country;
    data['city'] = city;
    data['age'] = age;
    data['social_facebook'] = socialFacebook;
    data['social_tiktok'] = socialTiktok;
    data['social_instagram'] = socialInstagram;
    data['social_twitter'] = socialTwitter;
    data['social_steam'] = socialSteam;
    data['social_pinterest'] = socialPinterest;
    data['social_linkedin'] = socialLinkedin;
    data['roles'] = roles;
    data['permissions'] = permissions;
    data['verified'] = verified;
    data['tfa_enabled'] = tfaEnabled;
    data['is_verified'] = isVerified;
    data['created_at'] = createdAt;
    data['is_active'] = isActive;
    data['status'] = status;
    data['active_at'] = activeAt;
    return data;
  }
}

class CustomEmoji {
  String? filename;
  String? fileUrl;

  CustomEmoji({this.filename, this.fileUrl});

  CustomEmoji.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['filename'] = filename;
    data['file_url'] = fileUrl;
    return data;
  }
}
