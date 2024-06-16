import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class UserRepository {
  Future<Either<FailureModel, Map>> getAllUsersRepo() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getUsers, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getBlockedUsersRepo(
      {required String uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getBlockedUsers + "/$uid", token: token);
    });
  }

  Future<Either<FailureModel, Map>> getRestrictedUsersRepo(
      {required String uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getRestrictedUsers + "/$uid", token: token);
    });
  }

  Future<Either<FailureModel, Map>> getMyRestrictedUsersRepo(
      {required String uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getMyRestrictedUsers + "/$uid", token: token);
    });
  }

  Future<Either<FailureModel, Map>> postRestrictUserRepo(
      Map<String, dynamic> data,
      {required String uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.postRestrictUser + "/$uid",
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> postBlockUserRepo(Map<String, dynamic> data,
      {required String uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.postBlockUser + "/$uid",
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteBlockUserRepo(
      {required String id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteBlockUser + "/$id", token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteUserRepo({required String id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteUser + "/$id", token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateUserDetails(Map<String, dynamic> data,
      {required String uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateUser + "/$uid", data: data, token: token);
    });
  }
}
