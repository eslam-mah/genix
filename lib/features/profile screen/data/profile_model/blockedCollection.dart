import 'package:equatable/equatable.dart';

import 'user.dart';

class BlockedCollection extends Equatable {
  final int? id;
  final User? user;
  final bool? isClose;

  const BlockedCollection({this.id, this.user, this.isClose});

  factory BlockedCollection.fromJson(Map<String, dynamic> json) {
    return BlockedCollection(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      isClose: json['is_close'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'is_close': isClose,
      };

  @override
  List<Object?> get props => [id, user, isClose];
}
