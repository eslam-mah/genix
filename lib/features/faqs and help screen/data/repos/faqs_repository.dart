import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class FaqsRepository {
  Future<Either<FailureModel, Map>> getAllDocuments() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getDocuments, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getDocumentsById(
      {required String id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getDocumentById + "/$id", token: token);
    });
  }
}
