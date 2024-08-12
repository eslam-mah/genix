import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';

///
/// List of Shorts model
/// includes data that comes from a non-filtered get Shorts request
///
class ShortsList {
  bool success;
  ShortsData data;
  String? message;

  ShortsList({
    required this.success,
    required this.data,
    this.message,
  });

  ShortsList.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        data = ShortsData.fromJson(json['data']),
        message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data.toJson();
    data['message'] = message;
    return data;
  }
}

///
/// ShortsData class is to handle the array of Shorts that comes from the non-filtered
/// GET request, separated from other meta data
///
class ShortsData {
  List<ShortsModel> collection;
  PaginationModel pagination;
  dynamic initial;

  ShortsData({
    required this.collection,
    required this.pagination,
    this.initial,
  });

  ShortsData.fromJson(Map<String, dynamic> json)
      : collection = (json['collection'] as List)
            .map((item) => ShortsModel.fromJson(item))
            .toList(),
        pagination = PaginationModel.fromJson(json['pagination']),
        initial = json['initial'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = collection.map((item) => item.toJson()).toList();
    data['pagination'] = pagination.toJson();
    data['initial'] = initial;
    return data;
  }
}
