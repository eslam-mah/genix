import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? username;
  final String? showname;
  final String? profileImg;
  final String? coverImg;
  final String? bio;
  final String? country;
  final String? city;
  final dynamic age;
  final String? socialFacebook;
  final dynamic socialTiktok;
  final dynamic socialInstagram;
  final String? socialTwitter;
  final String? socialSteam;
  final dynamic socialPinterest;
  final dynamic socialLinkedin;
  final List<dynamic>? roles;
  final bool? isVerified;
  final DateTime? createdAt;
  final bool? isActive;
  final int? status;
  final DateTime? activeAt;

  const User({
    this.id,
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
    this.activeAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        username: json['username'] as String?,
        showname: json['showname'] as String?,
        profileImg: json['profile_img'] as String?,
        coverImg: json['cover_img'] as String?,
        bio: json['bio'] as String?,
        country: json['country'] as String?,
        city: json['city'] as String?,
        age: json['age'] as dynamic,
        socialFacebook: json['social_facebook'] as String?,
        socialTiktok: json['social_tiktok'] as dynamic,
        socialInstagram: json['social_instagram'] as dynamic,
        socialTwitter: json['social_twitter'] as String?,
        socialSteam: json['social_steam'] as String?,
        socialPinterest: json['social_pinterest'] as dynamic,
        socialLinkedin: json['social_linkedin'] as dynamic,
        roles: json['roles'] as List<dynamic>?,
        isVerified: json['is_verified'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        isActive: json['is_active'] as bool?,
        status: json['status'] as int?,
        activeAt: json['active_at'] == null
            ? null
            : DateTime.parse(json['active_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'showname': showname,
        'profile_img': profileImg,
        'cover_img': coverImg,
        'bio': bio,
        'country': country,
        'city': city,
        'age': age,
        'social_facebook': socialFacebook,
        'social_tiktok': socialTiktok,
        'social_instagram': socialInstagram,
        'social_twitter': socialTwitter,
        'social_steam': socialSteam,
        'social_pinterest': socialPinterest,
        'social_linkedin': socialLinkedin,
        'roles': roles,
        'is_verified': isVerified,
        'created_at': createdAt?.toIso8601String(),
        'is_active': isActive,
        'status': status,
        'active_at': activeAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      username,
      showname,
      profileImg,
      coverImg,
      bio,
      country,
      city,
      age,
      socialFacebook,
      socialTiktok,
      socialInstagram,
      socialTwitter,
      socialSteam,
      socialPinterest,
      socialLinkedin,
      roles,
      isVerified,
      createdAt,
      isActive,
      status,
      activeAt,
    ];
  }
}
