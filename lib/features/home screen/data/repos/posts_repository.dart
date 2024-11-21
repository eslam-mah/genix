import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_file_helper.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class PostsRepository {
  // Future<Either<FailureModel, Map>> addPost(
  //     {required Map<String, dynamic> data}) async {
  //   return await HttpHelper.handleRequest((token) async {
  //     return await HttpHelper.postData(
  //         linkUrl: ApiEndPoints.addPost, data: data, token: token);
  //   });
  // }

  // Future<Either<FailureModel, Map>> addFilePost({
  //   required Map<String, dynamic> data,
  //   required List<File> files, // Support multiple files
  //   required String name, // Name for the file field
  // }) async {
  //   return await HttpHelper.handleRequest((token) async {
  //     return await HttpHelper.postMultipartData(
  //       linkUrl: ApiEndPoints.addPost,
  //       data: data,
  //       files: files,
  //       name: name,
  //       token: token,
  //     );
  //   });
  // }
  Future<Either<FailureModel, Map>> addPost({
    required String content,
    required String pageId,
    required String groupId,
    required String postingIn,
    required List<File> files,
    required String checkInLocation,
    required bool isLive,
    required bool cameraMirror,
    required String cameraId,
    required String deviceType,
    required String microphoneId,
    required bool checkIn,
    required bool toCloseFriends,
    required List<String> pollOptions,
    required bool poll,
    required String pollQuestion,
    required bool event,
    required String eventTimeStamp,
  }) async {
    return await HttpFileHelper.handleRequest((token) async {
      return await HttpFileHelper.postContent(
        url: ApiEndPoints.addPost,
        token: token,
        content: content,
        pageId: pageId,
        groupId: groupId,
        postingIn: postingIn,
        files: files,
        checkinLocation: checkInLocation,
        cameraId: cameraId,
        cameraMirror: cameraMirror,
        deviceType: 'mobile',
        isLive: isLive,
        microphoneId: microphoneId,
        checkin: checkIn,
        toCloseFriends: toCloseFriends,
        poll: poll,
        pollOptions: pollOptions,
        pollQuestion: pollQuestion,
        event: event,
        eventTimestamp: eventTimeStamp,
      );
    });
  }

  Future<Either<FailureModel, Map>> getPostById({required num postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPostById + '/$postId', token: token);
    });
  }

  Future<Either<FailureModel, Map>> updatePostById(
      {required Map<String, dynamic> data, required num postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updatePostById + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> addPollPost(
      {required num postId, required num option}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.addPollPost + '/$postId',
          data: {'option': option},
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deletePost({required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deletePost + '/$postId', token: token);
    });
  }

  Future<Either<FailureModel, Map>> removeReact({
    required int postId,
    required Map<String, dynamic> data,
  }) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.reactOnPost + '/$postId',
          token: token,
          data: data);
    });
  }

  Future<Either<FailureModel, Map>> addReact(
      {required Map<String, dynamic> data, required num postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.reactOnPost + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> sharePost(
      {required Map<String, dynamic> data, required num postId}) async {
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

  Future<Either<FailureModel, Map>> getTimelinePosts(
      {required int uid, required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPostsInTimeLineById + '/$uid?page=$page',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getNewsFeedPosts(
      {required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      print('Token: $token');
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPostsInNewsFeed + '?page=$page',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getStories({required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getStories + '?page=$page', token: token);
    });
  }

  Future<Either<FailureModel, Map>> savePost(
      {required Map<String, dynamic> data, required num postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.savePost + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> viewPost(
      {required Map<String, dynamic> data, required num postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.viewPost + '/$postId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> addDonationOnPost(
      {required Map<String, dynamic> data,
      required num postId,
      required String giftId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.addDonation + '/$postId?gift_id=$giftId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getLiveChannel({required num id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getLiveChannel + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteUserPost({required num uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteUserPost + '/$uid', token: token);
    });
  }
}
