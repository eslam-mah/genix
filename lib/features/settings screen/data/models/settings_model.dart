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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['email'] = this.email;
    data['coins'] = this.coins;
    data['revenue_coins'] = this.revenueCoins;
    data['revenue'] = this.revenue;
    data['allow_followers'] = this.allowFollowers;
    data['allow_notifications'] = this.allowNotifications;
    data['allow_tags'] = this.allowTags;
    data['allow_search_engines'] = this.allowSearchEngines;
    data['allow_emails'] = this.allowEmails;
    data['date_of_birth'] = this.dateOfBirth;
    data['paypal_email'] = this.paypalEmail;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['gender'] = this.gender;
    data['bio'] = this.bio;
    data['country'] = this.country;
    data['city'] = this.city;
    data['age'] = this.age;
    data['social_facebook'] = this.socialFacebook;
    data['social_tiktok'] = this.socialTiktok;
    data['social_instagram'] = this.socialInstagram;
    data['social_twitter'] = this.socialTwitter;
    data['social_steam'] = this.socialSteam;
    data['social_pinterest'] = this.socialPinterest;
    data['social_linkedin'] = this.socialLinkedin;
    data['roles'] = this.roles;

    data['permissions'] = this.permissions;

    data['verified'] = this.verified;
    data['tfa_enabled'] = this.tfaEnabled;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    data['active_at'] = this.activeAt;
    return data;
  }
}
