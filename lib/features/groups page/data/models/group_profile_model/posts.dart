import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

import 'collection.dart';
import 'pagination.dart';

class Posts {
  List<PostsModel>? collection;
  Pagination? pagination;

  Posts({this.collection, this.pagination});

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        collection: (json['collection'] as List<dynamic>?)
            ?.map((e) => PostsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'collection': collection?.map((e) => e.toJson()).toList(),
        'pagination': pagination?.toJson(),
      };
}
