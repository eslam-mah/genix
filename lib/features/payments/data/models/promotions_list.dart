import 'package:genix/features/payments/data/models/promotions_model.dart';

class PromotionsList {
  bool success;
  PromotionData data;
  String? message;

  PromotionsList({
    required this.success,
    required this.data,
    this.message,
  });

  factory PromotionsList.fromJson(Map<String, dynamic> json) {
    return PromotionsList(
      success: json['success'] ?? false,
      data: PromotionData.fromJson(json['data']),
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

class PromotionData {
  List<PromotionsModel> collection;
  Pagination pagination;

  PromotionData({
    required this.collection,
    required this.pagination,
  });

  factory PromotionData.fromJson(Map<String, dynamic> json) {
    return PromotionData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => PromotionsModel.fromJson(item))
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
