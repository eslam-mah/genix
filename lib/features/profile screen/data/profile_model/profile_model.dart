import 'package:equatable/equatable.dart';

import 'data.dart';

class ProfileModel extends Equatable {
	final bool? success;
	final Data? data;
	final dynamic message;

	const ProfileModel({this.success, this.data, this.message});

	factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
				success: json['success'] as bool?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
				message: json['message'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'success': success,
				'data': data?.toJson(),
				'message': message,
			};

	@override
	List<Object?> get props => [success, data, message];
}
