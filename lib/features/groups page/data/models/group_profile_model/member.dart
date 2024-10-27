import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';

import 'stats.dart';

class Member {
  int? id;
  UserModel? user;
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

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json['id'] as int?,
        user: json['user'] == null
            ? null
            : UserModel.fromJson(json['user'] as Map<String, dynamic>),
        roles: json['roles'] as List<dynamic>?,
        permissions: json['permissions'] as List<dynamic>?,
        stats: json['stats'] == null
            ? null
            : Stats.fromJson(json['stats'] as Map<String, dynamic>),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'roles': roles,
        'permissions': permissions,
        'stats': stats?.toJson(),
        'created_at': createdAt?.toIso8601String(),
      };
}
