import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class LockRepository {
  Future<Either<FailureModel, Map>> getLockAccount() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getLock, token: token);
    });
  }

  Future<Either<FailureModel, Map>> postLockAccount() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.postLock, data: {}, token: token);
    });
  }

  Future<Either<FailureModel, Map>> removeLockAccount(
      {required String password}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.removeLock,
          data: {"password": password},
          token: token);
    });
  }
}
