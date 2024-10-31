import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class RegisterRepository {
  Future<Either<FailureModel, Map>> register({
    required String email,
    required String password,
    required String showName,
    required String userName,
    required String passwordConfirmation,
    required String country,
    required String locale,
    required String dateOfBirth,
  }) async {
    return await HttpHelper.register(
      linkUrl: 'https://api.genix.social/api/register',
      showName: showName,
      username: userName,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      country: country,
      locale: locale,
      dateOfBirth: dateOfBirth,
    );
  }

  Future<Either<FailureModel, Map>> verifyEmail() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.verifyEmail, data: {}, token: token);
    });
  }
}
