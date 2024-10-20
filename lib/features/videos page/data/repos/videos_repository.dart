import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class VideosRepository {
  Future<Either<FailureModel, Map>> getVideoPosts({required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getVideoPosts + '/$uid', token: token);
    });
  }
}
