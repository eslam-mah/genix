import 'user.dart';

class FollowingCollection {
  int? id;
  User? user;
  bool isClose;

  FollowingCollection({this.id, this.user, required this.isClose});

  FollowingCollection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        isClose = json['is_close'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user?.toJson();
    data['is_close'] = this.isClose;
    return data;
  }
}
