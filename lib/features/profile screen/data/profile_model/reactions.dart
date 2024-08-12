import 'package:equatable/equatable.dart';

import 'summary.dart';

class Reactions extends Equatable {
  // final Summary? summary;
  final dynamic byMe;

  const Reactions(
      {
      // this.summary,
      this.byMe});

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
        // summary: json['summary'] == null
        // ? null
        // : Summary.fromJson(json['summary'] as Map<String, dynamic>),
        byMe: json['by_me'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        // 'summary': summary?.toJson(),
        'by_me': byMe,
      };

  @override
  List<Object?> get props => [
        // summary
        byMe
      ];
}
