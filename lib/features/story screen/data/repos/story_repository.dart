import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class StoryRepository {
  Future<Either<FailureModel, Map>> getStoryViewers(
      {required int uploadId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getStoryViewers + '/$uploadId', token: token);
    });
  }

  Future<Either<FailureModel, Map>> seeStory(Map<String, dynamic> data,
      {required int uploadId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.makeStorySeen + '/$uploadId',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> addStoryReact(
      {required Map<String, dynamic> data, required int uploadId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.addReactOnStory + '/$uploadId',
          data: data,
          token: token);
    });
  }
}
