import 'data.dart';

class GroupProfileModel {
  bool? success;
  Data? data;
  dynamic message;

  GroupProfileModel({this.success, this.data, this.message});

  factory GroupProfileModel.fromJson(Map<String, dynamic> json) {
    return GroupProfileModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'message': message,
      };
}
