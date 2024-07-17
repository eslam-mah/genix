import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

class PostsList {
  String status;
  Data data;

  PostsList({required this.status, required this.data});

  factory PostsList.fromJson(Map<String, dynamic> json) {
    return PostsList(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  List<PostsModel> posts;

  Data({required this.posts});

  factory Data.fromJson(Map<String, dynamic> json) {
    var postsJson = json['collection'] as List;
    List<PostsModel> postsList =
        postsJson.map((i) => PostsModel.fromJson(i)).toList();

    return Data(
      posts: postsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] =
        this.posts.map((postsModel) => postsModel.toJson()).toList();
    return data;
  }

  void addPost({required PostsModel post}) {
    this.posts.add(post);
  }

  void updatePost({required PostsModel newPost}) {
    final updatedPostIndex = this
        .posts
        .indexWhere((p) => p.collection?[0].id == newPost.collection?[0].id);
    if (updatedPostIndex != -1) {
      this.posts[updatedPostIndex] = newPost;
    }
  }

  void deletePost(int postId) {
    final removedPostIndex =
        this.posts.indexWhere((p) => p.collection?[0].id == postId);
    if (removedPostIndex != -1) {
      this.posts.removeAt(removedPostIndex);
    }
  }
}
