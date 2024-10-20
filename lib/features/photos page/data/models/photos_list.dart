import 'package:genix/features/photos%20page/data/models/photos_model.dart';

class PhotosList {
  bool success;
  PhotosData data;
  String? message;

  PhotosList({
    required this.success,
    required this.data,
    this.message,
  });

  factory PhotosList.fromJson(Map<String, dynamic> json) {
    return PhotosList(
      success: json['success'],
      data: PhotosData.fromJson(json['data']),
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

class PhotosData {
  List<PhotosModel> collection;
  Pagination pagination;
  UserModel user;

  PhotosData({
    required this.collection,
    required this.pagination,
    required this.user,
  });

  factory PhotosData.fromJson(Map<String, dynamic> json) {
    return PhotosData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => PhotosModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    data['pagination'] = this.pagination.toJson();
    data['user'] = this.user.toJson();
    return data;
  }
}

class Pagination {
  int currentPage;
  int from;
  int lastPage;
  int perPage;
  int to;
  int total;

  Pagination({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] ?? 1,
      from: json['from'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 15,
      to: json['to'] ?? 1,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
