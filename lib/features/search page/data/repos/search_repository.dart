import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class SearchRepository {
  Future<Either<FailureModel, Map>> searchByUser(
      {required String query}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.search + "?by=users&query=$query",
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> searchByGroup(
      {required String query}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.search + "?by=groups&query=$query",
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> searchByPage(
      {required String query}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.search + "?by=pages&query=$query",
          token: token);
    });
  }
}
