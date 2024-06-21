import 'package:genix/features/followers%20list%20page/data/models/followers_model.dart';
import 'package:genix/features/profile%20screen/data/models/followers_collection.dart';
import 'package:genix/features/profile%20screen/data/models/following_collection.dart';
import 'package:genix/features/profile%20screen/data/models/groups_collection.dart';
import 'package:genix/features/profile%20screen/data/models/photo.dart';
import 'package:genix/features/profile%20screen/data/models/posted_short.dart';
import 'package:genix/features/profile%20screen/data/models/profile_model.dart';
import 'package:genix/features/profile%20screen/data/models/recent_post.dart';
import 'package:genix/features/profile%20screen/data/models/saved_short.dart';

class ProfileModelList {
  String status;
  ProfileData data;

  ProfileModelList({required this.status, required this.data});

  factory ProfileModelList.fromJson(Map<String, dynamic> json) {
    return ProfileModelList(
      status: json['status'],
      data: ProfileData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['data'] = this.data.toJson();
    return data;
  }
}

class ProfileData {
  User user;
  int? reactionsCount;
  int? followersCount;
  int? followingCount;
  List<FollowingCollection> followingCollection;
  List<FollowersCollection>? followersCollection;
  List<dynamic>? blockCollection;
  List<dynamic>? restrictCollection;
  int? postsCount;
  List<Photo>? photos;
  List<dynamic>? videos;
  List<RecentPost>? recentPosts;
  List<GroupsCollection>? groupsCollection;
  List<PostedShort>? postedShorts;
  List<SavedShort>? savedShorts;
  dynamic myFollowing;
  dynamic myRestrict;

  ProfileData({
    required this.user,
    this.reactionsCount,
    this.followersCount,
    this.followingCount,
    required this.followingCollection,
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

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      user: User.fromJson(json['user']),
      reactionsCount: json['reactionsCount'],
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      followingCollection: (json['followingCollection'] as List<dynamic>)
          .map((e) => FollowingCollection.fromJson(e))
          .toList(),
      followersCollection: (json['followersCollection'] as List<dynamic>?)
          ?.map((e) => FollowersCollection.fromJson(e))
          .toList(),
      blockCollection: json['blockCollection'],
      restrictCollection: json['restrictCollection'],
      postsCount: json['postsCount'],
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e))
          .toList(),
      videos: json['videos'],
      recentPosts: (json['recentPosts'] as List<dynamic>?)
          ?.map((e) => RecentPost.fromJson(e))
          .toList(),
      groupsCollection: (json['groupsCollection'] as List<dynamic>?)
          ?.map((e) => GroupsCollection.fromJson(e))
          .toList(),
      postedShorts: (json['postedShorts'] as List<dynamic>?)
          ?.map((e) => PostedShort.fromJson(e))
          .toList(),
      savedShorts: (json['savedShorts'] as List<dynamic>?)
          ?.map((e) => SavedShort.fromJson(e))
          .toList(),
      myFollowing: json['myFollowing'],
      myRestrict: json['myRestrict'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = this.user.toJson();
    data['reactionsCount'] = this.reactionsCount;
    data['followersCount'] = this.followersCount;
    data['followingCount'] = this.followingCount;
    data['followingCollection'] =
        this.followingCollection.map((e) => e.toJson()).toList();
    data['followersCollection'] =
        this.followersCollection?.map((e) => e.toJson()).toList();
    data['blockCollection'] = this.blockCollection;
    data['restrictCollection'] = this.restrictCollection;
    data['postsCount'] = this.postsCount;
    data['photos'] = this.photos?.map((e) => e.toJson()).toList();
    data['videos'] = this.videos;
    data['recentPosts'] = this.recentPosts?.map((e) => e.toJson()).toList();
    data['groupsCollection'] =
        this.groupsCollection?.map((e) => e.toJson()).toList();
    data['postedShorts'] = this.postedShorts?.map((e) => e.toJson()).toList();
    data['savedShorts'] = this.savedShorts?.map((e) => e.toJson()).toList();
    data['myFollowing'] = this.myFollowing;
    data['myRestrict'] = this.myRestrict;
    return data;
  }
}
