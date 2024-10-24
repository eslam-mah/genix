class SettingsModel {
  bool? success;
  Data? data;
  String? message;

  SettingsModel({this.success, this.data, this.message});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? showname;
  String? email;
  int? coins;
  int? revenueCoins;
  double? revenue; // Adjusted to double as the example shows a decimal value
  bool? allowFollowers;
  bool? allowNotifications;
  bool? allowTags;
  bool? allowSearchEngines;
  bool? allowEmails;
  bool? hideGender;
  bool? hideLocation;
  bool? hideAge;
  String? dateOfBirth;
  String? paypalEmail;
  String? profileImg;
  String? coverImg;
  String? gender;
  String? bio;
  String? country;
  String? city;
  int? age;
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
  String? locale;
  String? activeAt;

  Data({
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
    this.hideGender,
    this.hideLocation,
    this.hideAge,
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
    this.locale,
    this.activeAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    showname = json['showname'];
    email = json['email'];
    coins = json['coins'];
    revenueCoins = json['revenue_coins'];
    revenue = json['revenue']?.toDouble();
    allowFollowers = json['allow_followers'];
    allowNotifications = json['allow_notifications'];
    allowTags = json['allow_tags'];
    allowSearchEngines = json['allow_search_engines'];
    allowEmails = json['allow_emails'];
    hideGender = json['hide_gender'];
    hideLocation = json['hide_location'];
    hideAge = json['hide_age'];
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
    roles = json['roles'] != null ? List<String>.from(json['roles']) : null;
    permissions = json['permissions'] != null
        ? List<String>.from(json['permissions'])
        : null;
    verified = json['verified'];
    tfaEnabled = json['tfa_enabled'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    isActive = json['is_active'];
    status = json['status'];
    locale = json['locale'];
    activeAt = json['active_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['hide_gender'] = hideGender;
    data['hide_location'] = hideLocation;
    data['hide_age'] = hideAge;
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
    data['locale'] = locale;
    data['active_at'] = activeAt;
    return data;
  }
}
