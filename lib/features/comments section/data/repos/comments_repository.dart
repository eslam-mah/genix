import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class CommentsRepository {
  Future<Either<FailureModel, Map>> addComment(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.addComment, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> addCommentReact(
      {required Map<String, dynamic> data,
      required int id,
      required int postId}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.reactOnComment + '/$id',
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteComment({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteComment + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteUserComment(
      {required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteUserComment + '/$uid', token: token);
    });
  }
}
