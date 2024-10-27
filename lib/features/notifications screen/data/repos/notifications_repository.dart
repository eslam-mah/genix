import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class NotificationsRepository {
  Future<Either<FailureModel, Map>> getAllNotifications(
      {required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getNotifications + '?page=$page', token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateNotification(
      {required Map<String, dynamic> data, required String id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.getNotifications + "/$id",
          data: data,
          token: token);
    });
  }
}
