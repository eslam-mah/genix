import 'creator_user.dart';
import 'me.dart';
import 'rating.dart';

class Page {
  int? id;
  String? name;
  String? profileImg;
  String? coverImg;
  String? category;
  String? website;
  String? about;
  String? socialFacebook;
  String? socialTiktok;
  String? socialInstagram;
  String? socialTwitter;
  String? socialSteam;
  String? socialPinterest;
  String? socialLinkedin;
  bool? isPrivate;
  int? membersCount;
  Me? me;
  CreatorUser? creatorUser;
  Rating? rating;

  Page({
    this.id,
    this.name,
    this.profileImg,
    this.coverImg,
    this.category,
    this.website,
    this.about,
    this.socialFacebook,
    this.socialTiktok,
    this.socialInstagram,
    this.socialTwitter,
    this.socialSteam,
    this.socialPinterest,
    this.socialLinkedin,
    this.isPrivate,
    this.membersCount,
    this.me,
    this.creatorUser,
    this.rating,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json['id'] as int?,
        name: json['name'] as String?,
        profileImg: json['profile_img'] as String?,
        coverImg: json['cover_img'] as String?,
        category: json['category'] as String?,
        website: json['website'] as String?,
        about: json['about'] as String?,
        socialFacebook: json['social_facebook'] as String?,
        socialTiktok: json['social_tiktok'] as String?,
        socialInstagram: json['social_instagram'] as String?,
        socialTwitter: json['social_twitter'] as String?,
        socialSteam: json['social_steam'] as String?,
        socialPinterest: json['social_pinterest'] as String?,
        socialLinkedin: json['social_linkedin'] as String?,
        isPrivate: json['is_private'] as bool?,
        membersCount: json['members_count'] as int?,
        me: json['me'] == null
            ? null
            : Me.fromJson(json['me'] as Map<String, dynamic>),
        creatorUser: json['creator_user'] == null
            ? null
            : CreatorUser.fromJson(
                json['creator_user'] as Map<String, dynamic>),
        rating: json['rating'] == null
            ? null
            : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'profile_img': profileImg,
        'cover_img': coverImg,
        'category': category,
        'website': website,
        'about': about,
        'social_facebook': socialFacebook,
        'social_tiktok': socialTiktok,
        'social_instagram': socialInstagram,
        'social_twitter': socialTwitter,
        'social_steam': socialSteam,
        'social_pinterest': socialPinterest,
        'social_linkedin': socialLinkedin,
        'is_private': isPrivate,
        'members_count': membersCount,
        'me': me?.toJson(),
        'creator_user': creatorUser?.toJson(),
        'rating': rating?.toJson(),
      };
}
