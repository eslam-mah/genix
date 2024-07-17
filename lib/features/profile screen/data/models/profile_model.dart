import 'followers_collection.dart';
import 'following_collection.dart';
import 'groups_collection.dart';
import 'photo.dart';
import 'posted_short.dart';
import 'recent_post.dart';
import 'saved_short.dart';
import 'user.dart';

class ProfileModel {
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

  ProfileModel({
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

  ProfileModel.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        reactionsCount = json['reactionsCount'],
        followersCount = json['followersCount'],
        followingCount = json['followingCount'],
        followingCollection = (json['followingCollection'] as List<dynamic>)
            .map((e) => FollowingCollection.fromJson(e))
            .toList(),
        followersCollection = (json['followersCollection'] as List<dynamic>?)
            ?.map((e) => FollowersCollection.fromJson(e))
            .toList(),
        blockCollection = json['blockCollection'],
        restrictCollection = json['restrictCollection'],
        postsCount = json['postsCount'],
        photos = (json['photos'] as List<dynamic>?)
            ?.map((e) => Photo.fromJson(e))
            .toList(),
        videos = json['videos'],
        recentPosts = (json['recentPosts'] as List<dynamic>?)
            ?.map((e) => RecentPost.fromJson(e))
            .toList(),
        groupsCollection = (json['groupsCollection'] as List<dynamic>?)
            ?.map((e) => GroupsCollection.fromJson(e))
            .toList(),
        postedShorts = (json['postedShorts'] as List<dynamic>?)
            ?.map((e) => PostedShort.fromJson(e))
            .toList(),
        savedShorts = (json['savedShorts'] as List<dynamic>?)
            ?.map((e) => SavedShort.fromJson(e))
            .toList(),
        myFollowing = json['myFollowing'],
        myRestrict = json['myRestrict'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
