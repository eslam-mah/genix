import 'package:equatable/equatable.dart';

import 'stats.dart';
import 'user.dart';

class Member extends Equatable {
	final int? id;
	final User? user;
	final List<dynamic>? roles;
	final List<dynamic>? permissions;
	final Stats? stats;
	final DateTime? createdAt;

	const Member({
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
						: User.fromJson(json['user'] as Map<String, dynamic>),
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

	@override
	List<Object?> get props {
		return [
				id,
				user,
				roles,
				permissions,
				stats,
				createdAt,
		];
	}
}
