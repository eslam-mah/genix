import 'package:equatable/equatable.dart';

import 'creator_user.dart';
import 'me.dart';
import 'rating.dart';

class GroupsCollection extends Equatable {
	final int? id;
	final String? name;
	final String? profileImg;
	final String? coverImg;
	final String? category;
	final String? website;
	final String? about;
	final String? socialFacebook;
	final dynamic socialTiktok;
	final dynamic socialInstagram;
	final dynamic socialTwitter;
	final dynamic socialSteam;
	final dynamic socialPinterest;
	final dynamic socialLinkedin;
	final bool? isPrivate;
	final int? membersCount;
	final Me? me;
	final CreatorUser? creatorUser;
	final Rating? rating;

	const GroupsCollection({
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

	factory GroupsCollection.fromJson(Map<String, dynamic> json) {
		return GroupsCollection(
			id: json['id'] as int?,
			name: json['name'] as String?,
			profileImg: json['profile_img'] as String?,
			coverImg: json['cover_img'] as String?,
			category: json['category'] as String?,
			website: json['website'] as String?,
			about: json['about'] as String?,
			socialFacebook: json['social_facebook'] as String?,
			socialTiktok: json['social_tiktok'] as dynamic,
			socialInstagram: json['social_instagram'] as dynamic,
			socialTwitter: json['social_twitter'] as dynamic,
			socialSteam: json['social_steam'] as dynamic,
			socialPinterest: json['social_pinterest'] as dynamic,
			socialLinkedin: json['social_linkedin'] as dynamic,
			isPrivate: json['is_private'] as bool?,
			membersCount: json['members_count'] as int?,
			me: json['me'] == null
						? null
						: Me.fromJson(json['me'] as Map<String, dynamic>),
			creatorUser: json['creator_user'] == null
						? null
						: CreatorUser.fromJson(json['creator_user'] as Map<String, dynamic>),
			rating: json['rating'] == null
						? null
						: Rating.fromJson(json['rating'] as Map<String, dynamic>),
		);
	}



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

	@override
	List<Object?> get props {
		return [
				id,
				name,
				profileImg,
				coverImg,
				category,
				website,
				about,
				socialFacebook,
				socialTiktok,
				socialInstagram,
				socialTwitter,
				socialSteam,
				socialPinterest,
				socialLinkedin,
				isPrivate,
				membersCount,
				me,
				creatorUser,
				rating,
		];
	}
}
