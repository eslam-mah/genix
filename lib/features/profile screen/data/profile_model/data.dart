import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/profile%20screen/data/profile_model/blockedCollection.dart';
import 'package:genix/features/profile%20screen/data/profile_model/restrictedCollection.dart';

import 'followers_collection.dart';
import 'following_collection.dart';
import 'groups_collection.dart';
import 'my_following.dart';
import 'photo.dart';
import 'posted_short.dart';
import 'recent_post.dart';
import 'saved_short.dart';
import 'user.dart';

class Data extends Equatable {
  final User? user;
  final int? reactionsCount;
  final int? followersCount;
  final int? followingCount;
  final List<FollowingCollection>? followingCollection;
  final List<FollowersCollection>? followersCollection;
  final List<BlockedCollection>? blockCollection;
  final List<RestrictedCollection>? restrictCollection;
  final int? postsCount;
  final List<Photo>? photos;
  final List<dynamic>? videos;
  final List<PostsModel>? recentPosts;
  final List<GroupsCollection>? groupsCollection;
  final List<PostedShort>? postedShorts;
  final List<SavedShort>? savedShorts;
  final MyFollowing? myFollowing;
  final dynamic myRestrict;

  const Data({
    this.user,
    this.reactionsCount,
    this.followersCount,
    this.followingCount,
    this.followingCollection,
    this.followersCollection,
    this.blockCollection,
    this.restrictCollection,
    this.postsCount,
    this.photos,
    this.videos,
    this.recentPosts,
    this.groupsCollection,
    this.postedShorts,
    this.savedShorts,
    this.myFollowing,
    this.myRestrict,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        reactionsCount: json['reactionsCount'] as int?,
        followersCount: json['followersCount'] as int?,
        followingCount: json['followingCount'] as int?,
        followingCollection: (json['followingCollection'] as List<dynamic>?)
            ?.map(
                (e) => FollowingCollection.fromJson(e as Map<String, dynamic>))
            .toList(),
        followersCollection: (json['followersCollection'] as List<dynamic>?)
            ?.map(
                (e) => FollowersCollection.fromJson(e as Map<String, dynamic>))
            .toList(),
        blockCollection: (json['blockCollection'] as List<dynamic>?)
            ?.map((e) => BlockedCollection.fromJson(e as Map<String, dynamic>))
            .toList(),
        restrictCollection: (json['restrictCollection'] as List<dynamic>?)
            ?.map(
                (e) => RestrictedCollection.fromJson(e as Map<String, dynamic>))
            .toList(),
        postsCount: json['postsCount'] as int?,
        photos: (json['photos'] as List<dynamic>?)
            ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
            .toList(),
        videos: json['videos'] as List<dynamic>?,
        recentPosts: (json['recentPosts'] as List<dynamic>?)
            ?.map((e) => PostsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        groupsCollection: (json['groupsCollection'] as List<dynamic>?)
            ?.map((e) => GroupsCollection.fromJson(e as Map<String, dynamic>))
            .toList(),
        postedShorts: (json['postedShorts'] as List<dynamic>?)
            ?.map((e) => PostedShort.fromJson(e as Map<String, dynamic>))
            .toList(),
        savedShorts: (json['savedShorts'] as List<dynamic>?)
            ?.map((e) => SavedShort.fromJson(e as Map<String, dynamic>))
            .toList(),
        myFollowing: json['myFollowing'] != null
            ? MyFollowing.fromJson(json['myFollowing'] as Map<String, dynamic>)
            : null,
        myRestrict: json['myRestrict'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'reactionsCount': reactionsCount,
        'followersCount': followersCount,
        'followingCount': followingCount,
        'followingCollection':
            followingCollection?.map((e) => e.toJson()).toList(),
        'followersCollection':
            followersCollection?.map((e) => e.toJson()).toList(),
        'blockCollection': blockCollection,
        'restrictCollection': restrictCollection,
        'postsCount': postsCount,
        'photos': photos?.map((e) => e.toJson()).toList(),
        'videos': videos,
        'recentPosts': recentPosts?.map((e) => e.toJson()).toList(),
        'groupsCollection': groupsCollection?.map((e) => e.toJson()).toList(),
        'postedShorts': postedShorts?.map((e) => e.toJson()).toList(),
        'savedShorts': savedShorts?.map((e) => e.toJson()).toList(),
        'myFollowing': myFollowing?.toJson(),
        'myRestrict': myRestrict,
      };

  @override
  List<Object?> get props {
    return [
      user,
      reactionsCount,
      followersCount,
      followingCount,
      followingCollection,
      followersCollection,
      blockCollection,
      restrictCollection,
      postsCount,
      photos,
      videos,
      recentPosts,
      groupsCollection,
      postedShorts,
      savedShorts,
      myFollowing,
      myRestrict,
    ];
  }
}
