import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class FollowingsRepository {
  Future<Either<FailureModel, Map>> getFollowings(
      {required int id, required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getFollowings + "/$id?page=$page",
          token: token);
    });
  }
}
