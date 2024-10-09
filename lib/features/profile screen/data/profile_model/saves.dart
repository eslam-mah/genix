import 'package:equatable/equatable.dart';

class Saves extends Equatable {
  final int? count;
  final bool? byMe;

  const Saves({this.count, this.byMe});

  factory Saves.fromJson(Map<String, dynamic> json) => Saves(
        count: json['count'] as int?,
        byMe: json['by_me'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'by_me': byMe,
      };

  @override
  List<Object?> get props => [count, byMe];
}
