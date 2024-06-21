import 'user.dart';

class FollowersCollection {
  int? id;
  User? user;
  bool? isClose;

  FollowersCollection({this.id, this.user, this.isClose});

  FollowersCollection.fromJson(Map<String, dynamic> json)
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
