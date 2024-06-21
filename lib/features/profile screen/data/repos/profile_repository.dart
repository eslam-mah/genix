import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class ProfileRepository {
  Future<Either<FailureModel, Map>> getProfileData(
      {required String profileName}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getProfile + "/$profileName", token: token);
    });
  }

  Future<Either<FailureModel, Map>> addFriend(
      {required Map<String, dynamic> data, required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.addFriend + "/$uid", data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> isCloseFriend(
      {required Map<String, dynamic> data,
      required int uid,
      required bool isClose}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateCloseFriend + "/$uid/?is_close=$isClose",
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> removeFriend({required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.removeFriend + "/$uid", token: token);
    });
  }
}
