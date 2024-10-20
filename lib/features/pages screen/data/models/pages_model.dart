class PagesModel {
  int id;
  String name;
  String profileImg;
  String coverImg;
  String category;
  String website;
  String? about;
  String? socialFacebook;
  String? socialTiktok;
  String? socialInstagram;
  String? socialTwitter;
  String? socialSteam;
  String? socialPinterest;
  String? socialLinkedin;
  int membersCount;
  Member me;
  Rating rating;

  PagesModel({
    required this.id,
    required this.name,
    required this.profileImg,
    required this.coverImg,
    required this.category,
    required this.website,
    this.about,
    this.socialFacebook,
    this.socialTiktok,
    this.socialInstagram,
    this.socialTwitter,
    this.socialSteam,
    this.socialPinterest,
    this.socialLinkedin,
    required this.membersCount,
    required this.me,
    required this.rating,
  });

  factory PagesModel.fromJson(Map<String, dynamic> json) {
    return PagesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profileImg: json['profile_img'] ?? '',
      coverImg: json['cover_img'] ?? '',
      category: json['category'] ?? '',
      website: json['website'] ?? '',
      about: json['about'],
      socialFacebook: json['social_facebook'],
      socialTiktok: json['social_tiktok'],
      socialInstagram: json['social_instagram'],
      socialTwitter: json['social_twitter'],
      socialSteam: json['social_steam'],
      socialPinterest: json['social_pinterest'],
      socialLinkedin: json['social_linkedin'],
      membersCount: json['members_count'] ?? 0,
      me: Member.fromJson(json['me'] ?? {}),
      rating: Rating.fromJson(json['rating'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['category'] = this.category;
    data['website'] = this.website;
    data['about'] = this.about;
    data['social_facebook'] = this.socialFacebook;
    data['social_tiktok'] = this.socialTiktok;
    data['social_instagram'] = this.socialInstagram;
    data['social_twitter'] = this.socialTwitter;
    data['social_steam'] = this.socialSteam;
    data['social_pinterest'] = this.socialPinterest;
    data['social_linkedin'] = this.socialLinkedin;
    data['members_count'] = this.membersCount;
    data['me'] = this.me.toJson();
    data['rating'] = this.rating.toJson();
    return data;
  }
}

class Member {
  MemberDetails member;
  bool manager;

  Member({
    required this.member,
    required this.manager,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      member: MemberDetails.fromJson(json['member'] ?? {}),
      manager: json['manager'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member'] = this.member.toJson();
    data['manager'] = this.manager;
    return data;
  }
}

class MemberDetails {
  int id;
  // User user;
  List<String> roles;
  List<String> permissions;
  Stats stats;
  DateTime createdAt;

  MemberDetails({
    required this.id,
    // required this.user,
    required this.roles,
    required this.permissions,
    required this.stats,
    required this.createdAt,
  });

  factory MemberDetails.fromJson(Map<String, dynamic> json) {
    return MemberDetails(
      id: json['id'] ?? 0,
      // user: User.fromJson(json['user']),
      roles: json['roles'] != null ? List<String>.from(json['roles']) : [],
      permissions: json['permissions'] != null
          ? List<String>.from(json['permissions'])
          : [],
      stats: Stats.fromJson(json['stats'] ?? {}),
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    // data['user'] = this.user.toJson();
    data['roles'] = this.roles;
    data['permissions'] = this.permissions;
    data['stats'] = this.stats.toJson();
    data['created_at'] = this.createdAt.toIso8601String();
    return data;
  }
}

class Stats {
  int postsCount;
  int postsCommentsCount;

  Stats({
    required this.postsCount,
    required this.postsCommentsCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      postsCount: json['posts_count'] ?? 0,
      postsCommentsCount: json['posts_comments_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posts_count'] = this.postsCount;
    data['posts_comments_count'] = this.postsCommentsCount;
    return data;
  }
}

class Rating {
  int average;
  int? myRating;

  Rating({
    required this.average,
    this.myRating,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average'] ?? 0,
      myRating: json['my_rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = this.average;
    data['my_rating'] = this.myRating;
    return data;
  }
}
