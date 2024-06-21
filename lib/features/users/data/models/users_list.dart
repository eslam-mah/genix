import 'package:genix/features/users/data/models/user_model.dart';

class UserList {
  String status;
  Data data;

  UserList({required this.status, required this.data});

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
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
  List<UserModel> users;

  Data({required this.users});

  factory Data.fromJson(Map<String, dynamic> json) {
    var usersJson = json['collection'] as List;
    List<UserModel> usersList =
        usersJson.map((i) => UserModel.fromJson(i)).toList();

    return Data(
      users: usersList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] =
        this.users.map((userModel) => userModel.toJson()).toList();
    return data;
  }

  void addUser({required UserModel user}) {
    this.users.add(user);
  }

  void updateUser({required UserModel newUser}) {
    final updatedUserIndex = this.users.indexWhere((u) => u.id == newUser.id);
    if (updatedUserIndex != -1) {
      this.users[updatedUserIndex] = newUser;
    }
  }

  void deleteUser(int userId) {
    final removedUserIndex = this.users.indexWhere((u) => u.id == userId);
    if (removedUserIndex != -1) {
      this.users.removeAt(removedUserIndex);
    }
  }
}
