import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class LogOutRepository {
  Future<Either<FailureModel, Map>> logOut() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.logOut, data: {}, token: token);
    });
  }
}
