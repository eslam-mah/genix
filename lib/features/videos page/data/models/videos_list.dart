import 'package:genix/features/users/data/models/user_model.dart';
import 'package:genix/features/videos%20page/data/models/videos_model.dart';

class VideosList {
  bool success;
  VideosData data;
  String? message;

  VideosList({
    required this.success,
    required this.data,
    this.message,
  });

  factory VideosList.fromJson(Map<String, dynamic> json) {
    return VideosList(
      success: json['success'],
      data: VideosData.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data.toJson();
    data['message'] = this.message;
    return data;
  }
}

class VideosData {
  List<VideosModel> collection;
  UserModel user;

  VideosData({
    required this.collection,
    required this.user,
  });

  factory VideosData.fromJson(Map<String, dynamic> json) {
    return VideosData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => VideosModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    data['user'] = this.user.toJson();
    return data;
  }
}
