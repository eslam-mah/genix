import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class PostsRepository {
  Future<Either<FailureModel, Map>> addPost(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.addPost, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getPostById({required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPostById + '/$postId', token: token);
    });
  }

  Future<Either<FailureModel, Map>> updatePostById(
      {required Map<String, dynamic> data, required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updatePostById + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> addPollPost(
      {required Map<String, dynamic> data,
      required int postId,
      required int option}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.addPollPost + '/$postId?option=$option',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deletePost({required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deletePost + '/$postId', token: token);
    });
  }

  Future<Either<FailureModel, Map>> addReact(
      {required Map<String, dynamic> data, required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.reactOnPost + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> sharePost(
      {required Map<String, dynamic> data, required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.sharePost + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getReactions() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getReaction, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getTimelinePosts({required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPostsInTimeLineById + '/$uid', token: token);
    });
  }

  Future<Either<FailureModel, Map>> getNewsFeedPosts() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPostsInNewsFeed, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getPhotoPosts({required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPhotoPosts + '/$uid', token: token);
    });
  }

  Future<Either<FailureModel, Map>> getVideoPosts({required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getVideoPosts + '/$uid', token: token);
    });
  }

  Future<Either<FailureModel, Map>> getStories() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getStories, token: token);
    });
  }

  Future<Either<FailureModel, Map>> savePost(
      {required Map<String, dynamic> data, required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.savePost + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> viewPost(
      {required Map<String, dynamic> data, required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.viewPost + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> addDonationOnPost(
      {required Map<String, dynamic> data,
      required int postId,
      required String giftId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.addDonation + '/$postId?gift_id=$giftId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getLiveChannel({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getLiveChannel + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteUserPost({required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteUserPost + '/$uid', token: token);
    });
  }
}
