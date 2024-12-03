import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class LogInRepository {
  Future<Either<FailureModel, Map>> logIn({
    required String email,
    required String password,
    String? code, // Optional 2FA code
  }) async {
    final data = {
      'email': email,
      'password': password,
    };
    if (code != null) {
      data['code'] = code;
    }

    return await HttpHelper.login(
      linkUrl: ApiEndPoints.logIn,
      data: data,
    );
  }
}
