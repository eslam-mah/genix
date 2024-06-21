import 'stats.dart';
import 'user.dart';

class Member {
  int? id;
  User? user;
  List<dynamic>? roles;
  List<dynamic>? permissions;
  Stats? stats;
  DateTime? createdAt;

  Member({
    this.id,
    this.user,
    this.roles,
    this.permissions,
    this.stats,
    this.createdAt,
  });

  Member.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        roles = json['roles'],
        permissions = json['permissions'],
        stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null,
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user?.toJson();
    data['roles'] = this.roles;
    data['permissions'] = this.permissions;
    data['stats'] = this.stats?.toJson();
    data['created_at'] = this.createdAt?.toString();
    return data;
  }
}
