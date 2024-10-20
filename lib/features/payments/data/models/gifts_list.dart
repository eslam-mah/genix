import 'package:genix/features/payments/data/models/gifts_model.dart';

class GiftsList {
  bool success;
  GiftData data;
  String? message;

  GiftsList({
    required this.success,
    required this.data,
    this.message,
  });

  factory GiftsList.fromJson(Map<String, dynamic> json) {
    return GiftsList(
      success: json['success'],
      data: GiftData.fromJson(json['data']),
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

class GiftData {
  List<GiftsModel> collection;
  Pagination pagination;

  GiftData({
    required this.collection,
    required this.pagination,
  });

  factory GiftData.fromJson(Map<String, dynamic> json) {
    return GiftData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => GiftsModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    data['pagination'] = this.pagination.toJson();
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
      currentPage: json['current_page'] ?? 0,
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      to: json['to'] ?? 0,
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
