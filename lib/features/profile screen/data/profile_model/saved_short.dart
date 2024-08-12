import 'package:equatable/equatable.dart';

import 'comment.dart';
import 'misc.dart';
import 'reactions.dart';
import 'revenue.dart';
import 'saves.dart';
import 'user.dart';

class SavedShort extends Equatable {
	final int? id;
	final User? user;
	final String? content;
	final bool? isVideoShort;
	final bool? isProcessing;
	final String? thumbnailUrl;
	final String? fileUrl;
	final int? viewsUnique;
	final Reactions? reactions;
	final List<Comment>? comments;
	final int? commentsCount;
	final int? sharesCount;
	final Saves? saves;
	final Revenue? revenue;
	final Misc? misc;
	final DateTime? createdAt;
	final DateTime? updatedAt;

	const SavedShort({
		this.id, 
		this.user, 
		this.content, 
		this.isVideoShort, 
		this.isProcessing, 
		this.thumbnailUrl, 
		this.fileUrl, 
		this.viewsUnique, 
		this.reactions, 
		this.comments, 
		this.commentsCount, 
		this.sharesCount, 
		this.saves, 
		this.revenue, 
		this.misc, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory SavedShort.fromJson(Map<String, dynamic> json) => SavedShort(
				id: json['id'] as int?,
				user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
				content: json['content'] as String?,
				isVideoShort: json['is_video_short'] as bool?,
				isProcessing: json['is_processing'] as bool?,
				thumbnailUrl: json['thumbnail_url'] as String?,
				fileUrl: json['file_url'] as String?,
				viewsUnique: json['views_unique'] as int?,
				reactions: json['reactions'] == null
						? null
						: Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
				comments: (json['comments'] as List<dynamic>?)
						?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
						.toList(),
				commentsCount: json['comments_count'] as int?,
				sharesCount: json['shares_count'] as int?,
				saves: json['saves'] == null
						? null
						: Saves.fromJson(json['saves'] as Map<String, dynamic>),
				revenue: json['revenue'] == null
						? null
						: Revenue.fromJson(json['revenue'] as Map<String, dynamic>),
				misc: json['misc'] == null
						? null
						: Misc.fromJson(json['misc'] as Map<String, dynamic>),
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'user': user?.toJson(),
				'content': content,
				'is_video_short': isVideoShort,
				'is_processing': isProcessing,
				'thumbnail_url': thumbnailUrl,
				'file_url': fileUrl,
				'views_unique': viewsUnique,
				'reactions': reactions?.toJson(),
				'comments': comments?.map((e) => e.toJson()).toList(),
				'comments_count': commentsCount,
				'shares_count': sharesCount,
				'saves': saves?.toJson(),
				'revenue': revenue?.toJson(),
				'misc': misc?.toJson(),
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};

	@override
	List<Object?> get props {
		return [
				id,
				user,
				content,
				isVideoShort,
				isProcessing,
				thumbnailUrl,
				fileUrl,
				viewsUnique,
				reactions,
				comments,
				commentsCount,
				sharesCount,
				saves,
				revenue,
				misc,
				createdAt,
				updatedAt,
		];
	}
}
