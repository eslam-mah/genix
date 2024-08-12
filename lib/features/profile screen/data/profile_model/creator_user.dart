import 'package:equatable/equatable.dart';

class CreatorUser extends Equatable {
  final int? id;
  final String? username;
  final String? showname;
  final String? profileImg;
  final String? coverImg;
  final List<dynamic>? roles;
  final bool? isVerified;
  final DateTime? createdAt;
  final bool? isActive;
  final int? status;
  final DateTime? activeAt;

  const CreatorUser({
    this.id,
    this.username,
    this.showname,
    this.profileImg,
    this.coverImg,
    this.roles,
    this.isVerified,
    this.createdAt,
    this.isActive,
    this.status,
    this.activeAt,
  });

  factory CreatorUser.fromJson(Map<String, dynamic> json) => CreatorUser(
        id: json['id'] as int?,
        username: json['username'] as String?,
        showname: json['showname'] as String?,
        profileImg: json['profile_img'] as String?,
        coverImg: json['cover_img'] as String?,
        roles: json['roles'] as List<dynamic>?,
        isVerified: json['is_verified'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        isActive: json['is_active'] as bool?,
        status: json['status'] as int?,
        activeAt: json['active_at'] == null
            ? null
            : DateTime.parse(json['active_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'showname': showname,
        'profile_img': profileImg,
        'cover_img': coverImg,
        'roles': roles,
        'is_verified': isVerified,
        'created_at': createdAt?.toIso8601String(),
        'is_active': isActive,
        'status': status,
        'active_at': activeAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      username,
      showname,
      profileImg,
      coverImg,
      roles,
      isVerified,
      createdAt,
      isActive,
      status,
      activeAt,
    ];
  }
}
