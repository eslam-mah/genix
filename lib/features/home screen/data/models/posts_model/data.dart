import 'posts_model.dart';
import 'pagination.dart';

class Data {
  List<PostsModel>? collection;
  Pagination? pagination;
  dynamic promoted;
  bool? suggested;

  Data({
    this.collection,
    this.pagination,
    this.promoted,
    this.suggested,
  });

  Data.fromJson(Map<String, dynamic> json)
      : collection = (json['collection'] as List<dynamic>?)
            ?.map((e) => PostsModel.fromJson(e as Map<String, dynamic>))
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
