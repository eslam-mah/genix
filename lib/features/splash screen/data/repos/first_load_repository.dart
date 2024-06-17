import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/services/http_reponse_status.dart';

class FirstLoadRepository {
  Future<Either<FailureModel, Map>> getFirstLoad() async {
    try {
      final response = await HttpHelper.handleRequest((token) async {
        return await HttpHelper.getData(
            linkUrl: "https://api.genix.social/api/firstload", token: token);
      });
      print("Response: $response"); // Debugging line
      return response;
    } catch (e) {
      print("Error: $e"); // Debugging line
      return Left(FailureModel(
          message: e.toString(),
          responseStatus: HttpResponseStatus.unAuthorized));
    }
  }
}
