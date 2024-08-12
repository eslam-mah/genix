import 'package:equatable/equatable.dart';

class Summary extends Equatable {
	final int? love;
	final int? wow;

	const Summary({this.love, this.wow});

	factory Summary.fromJson(Map<String, dynamic> json) => Summary(
				love: json['love'] as int?,
				wow: json['wow'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'love': love,
				'wow': wow,
			};

	@override
	List<Object?> get props => [love, wow];
}
