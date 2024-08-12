import 'package:equatable/equatable.dart';

import 'reactions.dart';
import 'user.dart';

class Comment extends Equatable {
	final int? id;
	final User? user;
	final int? postId;
	final String? content;
	final Reactions? reactions;
	final DateTime? createdAt;

	const Comment({
		this.id, 
		this.user, 
		this.postId, 
		this.content, 
		this.reactions, 
		this.createdAt, 
	});

	factory Comment.fromJson(Map<String, dynamic> json) => Comment(
				id: json['id'] as int?,
				user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
				postId: json['post_id'] as int?,
				content: json['content'] as String?,
				reactions: json['reactions'] == null
						? null
						: Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'user': user?.toJson(),
				'post_id': postId,
				'content': content,
				'reactions': reactions?.toJson(),
				'created_at': createdAt?.toIso8601String(),
			};

	@override
	List<Object?> get props {
		return [
				id,
				user,
				postId,
				content,
				reactions,
				createdAt,
		];
	}
}
