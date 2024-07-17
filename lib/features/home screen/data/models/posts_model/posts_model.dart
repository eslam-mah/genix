import 'collection.dart';
import 'pagination.dart';

class PostsModel {
  List<Collection>? collection;
  Pagination? pagination;
  dynamic promoted;
  bool? suggested;

  PostsModel({
    this.collection,
    this.pagination,
    this.promoted,
    this.suggested,
  });

  PostsModel.fromJson(Map<String, dynamic> json)
      : collection = (json['collection'] as List<dynamic>?)
            ?.map((e) => Collection.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination = json['pagination'] != null
            ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
            : null,
        promoted = json['promoted'],
        suggested = json['suggested'] as bool?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (collection != null) {
      data['collection'] = collection!.map((e) => e.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    data['promoted'] = promoted;
    data['suggested'] = suggested;
    return data;
  }
}
