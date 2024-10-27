import 'data.dart';

class PageProfileModel {
  bool? success;
  Data? data;
  dynamic message;

  PageProfileModel({this.success, this.data, this.message});

  factory PageProfileModel.fromJson(Map<String, dynamic> json) {
    return PageProfileModel(
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
