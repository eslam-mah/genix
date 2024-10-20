import 'package:equatable/equatable.dart';

import 'user.dart';

class FollowingCollection extends Equatable {
  final int? id;
  final User? user;
  final bool? isClose;

  const FollowingCollection({this.id, this.user, this.isClose});

  factory FollowingCollection.fromJson(Map<String, dynamic> json) {
    return FollowingCollection(
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
