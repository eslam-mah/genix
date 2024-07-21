import 'package:genix/features/home%20screen/data/models/posts_model/pagination.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

class PostsList {
  bool success;
  Data data;

  PostsList({required this.success, required this.data});

  factory PostsList.fromJson(Map<String, dynamic> json) {
    return PostsList(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  List<PostsModel> postsModel;
  Pagination? pagination;
  dynamic promoted;
  bool? suggested;

  Data({
    required this.postsModel,
    this.pagination,
    this.promoted,
    this.suggested,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      postsModel: (json['collection'] as List<dynamic>)
          .map((item) => PostsModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      promoted: json['promoted'],
      suggested: json['suggested'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.postsModel.map((item) => item.toJson()).toList();
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    data['promoted'] = promoted;
    data['suggested'] = suggested;
    return data;
  }

  void addPost({required PostsModel post}) {
    this.postsModel.add(post);
  }

  void updatePost({required PostsModel newPost}) {
    final updatedPostIndex =
        this.postsModel.indexWhere((p) => p.id == newPost.id);
    if (updatedPostIndex != -1) {
      this.postsModel[updatedPostIndex] = newPost;
    }
  }

  void deletePost(int postId) {
    final removedPostIndex = this.postsModel.indexWhere((p) => p.id == postId);
    if (removedPostIndex != -1) {
      this.postsModel.removeAt(removedPostIndex);
    }
  }
}
