import 'package:genix/features/followers%20list%20page/data/models/followers_model.dart';

class FollowersList {
  bool success;
  FollowersData data;
  String? message;

  FollowersList({
    required this.success,
    required this.data,
    this.message,
  });

  factory FollowersList.fromJson(Map<String, dynamic> json) {
    return FollowersList(
      success: json['success'],
      data: FollowersData.fromJson(json['data']),
      message: json['message'] ?? '',
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

class FollowersData {
  List<FollowersModel> collection;
  UserModel user;

  FollowersData({
    required this.collection,
    required this.user,
  });

  factory FollowersData.fromJson(Map<String, dynamic> json) {
    return FollowersData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => FollowersModel.fromJson(item as Map<String, dynamic>))
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
