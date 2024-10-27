import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class FollowersRepository {
  Future<Either<FailureModel, Map>> getFollowers(
      {required int id, required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getFollowers + "/$id?page=$page", token: token);
    });
  }
}
