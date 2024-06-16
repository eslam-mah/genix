import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class LogInRepository {
  Future<Either<FailureModel, Map>> logIn(
      {required String email, required String password}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.logIn + "?email=$email&password=$password",
          data: {},
          token: null);
    });
  }
}
