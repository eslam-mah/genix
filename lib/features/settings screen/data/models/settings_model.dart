class SettingsModel {
  int? id;
  String? username;
  String? showname;
  String? email;
  int? coins;
  int? revenueCoins;
  int? revenue;
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

  SettingsModel(
      {this.id,
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
      this.activeAt});

  SettingsModel.fromJson(Map<String, dynamic> json) {
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
    roles = json['roles'].cast<String>();
    if (json['permissions'] != String) {
      permissions = json['permissions'];
    }
    verified = json['verified'];
    tfaEnabled = json['tfa_enabled'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    isActive = json['is_active'];
    status = json['status'];
    activeAt = json['active_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> SettingsModel = new Map<String, dynamic>();
    SettingsModel['id'] = this.id;
    SettingsModel['username'] = this.username;
    SettingsModel['showname'] = this.showname;
    SettingsModel['email'] = this.email;
    SettingsModel['coins'] = this.coins;
    SettingsModel['revenue_coins'] = this.revenueCoins;
    SettingsModel['revenue'] = this.revenue;
    SettingsModel['allow_followers'] = this.allowFollowers;
    SettingsModel['allow_notifications'] = this.allowNotifications;
    SettingsModel['allow_tags'] = this.allowTags;
    SettingsModel['allow_search_engines'] = this.allowSearchEngines;
    SettingsModel['allow_emails'] = this.allowEmails;
    SettingsModel['date_of_birth'] = this.dateOfBirth;
    SettingsModel['paypal_email'] = this.paypalEmail;
    SettingsModel['profile_img'] = this.profileImg;
    SettingsModel['cover_img'] = this.coverImg;
    SettingsModel['gender'] = this.gender;
    SettingsModel['bio'] = this.bio;
    SettingsModel['country'] = this.country;
    SettingsModel['city'] = this.city;
    SettingsModel['age'] = this.age;
    SettingsModel['social_facebook'] = this.socialFacebook;
    SettingsModel['social_tiktok'] = this.socialTiktok;
    SettingsModel['social_instagram'] = this.socialInstagram;
    SettingsModel['social_twitter'] = this.socialTwitter;
    SettingsModel['social_steam'] = this.socialSteam;
    SettingsModel['social_pinterest'] = this.socialPinterest;
    SettingsModel['social_linkedin'] = this.socialLinkedin;
    SettingsModel['roles'] = this.roles;

    SettingsModel['permissions'] = this.permissions;

    SettingsModel['verified'] = this.verified;
    SettingsModel['tfa_enabled'] = this.tfaEnabled;
    SettingsModel['is_verified'] = this.isVerified;
    SettingsModel['created_at'] = this.createdAt;
    SettingsModel['is_active'] = this.isActive;
    SettingsModel['status'] = this.status;
    SettingsModel['active_at'] = this.activeAt;
    return SettingsModel;
  }
}
