import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class PhotosRepository {
  Future<Either<FailureModel, Map>> getPhotoPosts({required num uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPhotoPosts + '/$uid', token: token);
    });
  }
}
