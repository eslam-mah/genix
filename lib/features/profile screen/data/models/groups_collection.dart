import 'creator_user.dart';
import 'me.dart';
import 'rating.dart';

class GroupsCollection {
  int? id;
  String? name;
  String? profileImg;
  String? coverImg;
  String? category;
  String? website;
  String? about;
  String? socialFacebook;
  dynamic socialTiktok;
  dynamic socialInstagram;
  dynamic socialTwitter;
  dynamic socialSteam;
  dynamic socialPinterest;
  dynamic socialLinkedin;
  bool? isPrivate;
  int? membersCount;
  Me? me;
  CreatorUser? creatorUser;
  Rating? rating;

  GroupsCollection({
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

  GroupsCollection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        profileImg = json['profile_img'],
        coverImg = json['cover_img'],
        category = json['category'],
        website = json['website'],
        about = json['about'],
        socialFacebook = json['social_facebook'],
        socialTiktok = json['social_tiktok'],
        socialInstagram = json['social_instagram'],
        socialTwitter = json['social_twitter'],
        socialSteam = json['social_steam'],
        socialPinterest = json['social_pinterest'],
        socialLinkedin = json['social_linkedin'],
        isPrivate = json['is_private'],
        membersCount = json['members_count'],
        me = json['me'] != null ? Me.fromJson(json['me']) : null,
        creatorUser = json['creator_user'] != null
            ? CreatorUser.fromJson(json['creator_user'])
            : null,
        rating =
            json['rating'] != null ? Rating.fromJson(json['rating']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['is_private'] = this.isPrivate;
    data['members_count'] = this.membersCount;
    data['me'] = this.me?.toJson();
    data['creator_user'] = this.creatorUser?.toJson();
    data['rating'] = this.rating?.toJson();
    return data;
  }
}
