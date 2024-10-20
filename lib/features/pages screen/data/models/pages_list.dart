import 'package:genix/features/pages%20screen/data/models/pages_model.dart';

class PagesList {
  bool success;
  PageData data;
  String? message;

  PagesList({
    required this.success,
    required this.data,
    this.message,
  });

  factory PagesList.fromJson(Map<String, dynamic> json) {
    return PagesList(
      success: json['success'],
      data: PageData.fromJson(json['data']),
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

class PageData {
  List<PagesModel> collection;
  List<PagesModel>? managed;
  List<PagesModel>? suggested;

  PageData({
    required this.collection,
    required this.managed,
    required this.suggested,
  });

  factory PageData.fromJson(Map<String, dynamic> json) {
    return PageData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => PagesModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      managed: json['managed'] != null && json['managed'] is List<dynamic>
          ? (json['managed'] as List<dynamic>)
              .map((item) => PagesModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      suggested: json['suggested'] != null && json['suggested'] is List<dynamic>
          ? (json['suggested'] as List<dynamic>)
              .map((item) => PagesModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    data['managed'] = this.managed?.map((item) => item.toJson()).toList();
    data['suggested'] = this.suggested?.map((item) => item.toJson()).toList();
    return data;
  }
}
