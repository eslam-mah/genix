import 'package:genix/features/users/data/models/user_model.dart';

class UserList {
  bool success;
  UserData data;
  String? message;

  UserList({
    required this.success,
    required this.data,
    this.message,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      success: json['success'],
      data: UserData.fromJson(json['data']),
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

class UserData {
  List<UserModel> collection;

  UserData({
    required this.collection,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    return data;
  }
}
