import 'package:genix/features/followers%20list%20page/data/models/followers_model.dart';

class FollowersList {
  String status;
  Data data;

  FollowersList({required this.status, required this.data});

  factory FollowersList.fromJson(Map<String, dynamic> json) {
    return FollowersList(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  List<FollowersModel> followers;

  Data({required this.followers});

  factory Data.fromJson(Map<String, dynamic> json) {
    var followersJson = json['collection'] as List;
    List<FollowersModel> followersList =
        followersJson.map((i) => FollowersModel.fromJson(i)).toList();

    return Data(
      followers: followersList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this
        .followers
        .map((followersModel) => followersModel.toJson())
        .toList();
    return data;
  }

  void addFollower({required FollowersModel follower}) {
    this.followers.add(follower);
  }

  void updateFollower({required FollowersModel newFollower}) {
    final updatedFollowerIndex =
        this.followers.indexWhere((f) => f.user.id == newFollower.user.id);
    if (updatedFollowerIndex != -1) {
      this.followers[updatedFollowerIndex] = newFollower;
    }
  }

  void deleteFollower(int userId) {
    final removedFollowerIndex =
        this.followers.indexWhere((f) => f.user.id == userId);
    if (removedFollowerIndex != -1) {
      this.followers.removeAt(removedFollowerIndex);
    }
  }
}
