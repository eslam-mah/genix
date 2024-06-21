import 'package:genix/features/followings%20list%20page/data/models/followings_model.dart';

class FollowingsList {
  String status;
  Data data;

  FollowingsList({required this.status, required this.data});

  factory FollowingsList.fromJson(Map<String, dynamic> json) {
    return FollowingsList(
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
  List<FollowingsModel> followings;

  Data({required this.followings});

  factory Data.fromJson(Map<String, dynamic> json) {
    var followingsJson = json['collection'] as List;
    List<FollowingsModel> followingsList =
        followingsJson.map((i) => FollowingsModel.fromJson(i)).toList();

    return Data(
      followings: followingsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this
        .followings
        .map((followingsModel) => followingsModel.toJson())
        .toList();
    return data;
  }

  void addFollowing({required FollowingsModel following}) {
    this.followings.add(following);
  }

  void updateFollowing({required FollowingsModel newFollowing}) {
    final updatedFollowingIndex =
        this.followings.indexWhere((f) => f.user.id == newFollowing.user.id);
    if (updatedFollowingIndex != -1) {
      this.followings[updatedFollowingIndex] = newFollowing;
    }
  }

  void deleteFollowing(int userId) {
    final removedFollowingIndex =
        this.followings.indexWhere((f) => f.user.id == userId);
    if (removedFollowingIndex != -1) {
      this.followings.removeAt(removedFollowingIndex);
    }
  }
}
