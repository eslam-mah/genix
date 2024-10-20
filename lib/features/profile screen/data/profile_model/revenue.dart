import 'package:equatable/equatable.dart';

class Revenue extends Equatable {
  final int? total;
  final List<dynamic>? top;

  const Revenue({this.total, this.top});

  factory Revenue.fromJson(Map<String, dynamic> json) => Revenue(
        total: json['total'] as int?,
        top: json['top'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'top': top,
      };

  @override
  List<Object?> get props => [total, top];
}
