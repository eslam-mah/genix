class User {
  int id;
  String? username;
  String showname;
  String? profileImg;
  String? coverImg;
  String? bio;
  String? country;
  String? city;
  dynamic age;
  String? socialFacebook;
  dynamic socialTiktok;
  dynamic socialInstagram;
  String? socialTwitter;
  String? socialSteam;
  dynamic socialPinterest;
  dynamic socialLinkedin;
  List<String>? roles;
  bool? isVerified;
  DateTime? createdAt;
  bool? isActive;
  int? status;
  DateTime? activeAt;

  User({
    required this.id,
    this.username,
    required this.showname,
    this.profileImg,
    this.coverImg,
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
    this.isVerified,
    this.createdAt,
    this.isActive,
    this.status,
    this.activeAt,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        showname = json['showname'],
        profileImg = json['profile_img'],
        coverImg = json['cover_img'],
        bio = json['bio'],
        country = json['country'],
        city = json['city'],
        age = json['age'],
        socialFacebook = json['social_facebook'],
        socialTiktok = json['social_tiktok'],
        socialInstagram = json['social_instagram'],
        socialTwitter = json['social_twitter'],
        socialSteam = json['social_steam'],
        socialPinterest = json['social_pinterest'],
        socialLinkedin = json['social_linkedin'],
        roles = json['roles']?.cast<String>(),
        isVerified = json['is_verified'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        isActive = json['is_active'],
        status = json['status'],
        activeAt = json['active_at'] != null
            ? DateTime.parse(json['active_at'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
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
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt?.toString();
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    data['active_at'] = this.activeAt?.toString();
    return data;
  }
}
