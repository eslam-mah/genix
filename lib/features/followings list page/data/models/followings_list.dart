import 'package:genix/features/followings%20list%20page/data/models/followings_model.dart';

class FollowingsList {
  bool success;
  FollowingData data;
  String? message;

  FollowingsList({
    required this.success,
    required this.data,
    this.message,
  });

  factory FollowingsList.fromJson(Map<String, dynamic> json) {
    return FollowingsList(
      success: json['success'],
      data: FollowingData.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data.toJson();
    data['message'] = this.message;
    return data;
  }
}

class FollowingData {
  List<FollowingsModel> collection;
  UserModel user;

  FollowingData({
    required this.collection,
    required this.user,
  });

  factory FollowingData.fromJson(Map<String, dynamic> json) {
    return FollowingData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => FollowingsModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    data['user'] = this.user.toJson();
    return data;
  }
}
