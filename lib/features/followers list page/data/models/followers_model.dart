class FollowersModel {
  List<Collection>? collection;
  User user;

  FollowersModel({this.collection, required this.user});

  FollowersModel.fromJson(Map<String, dynamic> json)
      : collection = json['collection'] != null
            ? List<Collection>.from(
                json['collection'].map((v) => Collection.fromJson(v)))
            : null,
        user = json['user'] != null
            ? User.fromJson(json['user'])
            : throw Exception("User cannot be null");

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    data['user'] = this.user.toJson();
    return data;
  }
}

class Collection {
  int? id;
  User? user;
  bool? isClose;

  Collection({this.id, this.user, this.isClose});

  Collection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        isClose = json['is_close'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['is_close'] = this.isClose;
    return data;
  }
}

class User {
  int id;
  String? username;
  String? showname;
  String? profileImg;
  String? coverImg;
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
  bool? isVerified;
  String? createdAt;
  bool? isActive;
  int? status;
  String? activeAt;

  User(
      {required this.id,
      this.username,
      this.showname,
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
      this.activeAt});

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
        roles = json['roles'].cast<String>(),
        isVerified = json['is_verified'],
        createdAt = json['created_at'],
        isActive = json['is_active'],
        status = json['status'],
        activeAt = json['active_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['created_at'] = this.createdAt;
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    data['active_at'] = this.activeAt;
    return data;
  }
}
