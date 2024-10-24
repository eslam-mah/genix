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

      if (response.isRight()) {
        return response; // Return success response as Map
      } else {
        // Assuming the HttpHelper can return a FailureModel containing the HttpResponseStatus
        final failure = response.fold((l) => l, (r) => null);
        return Left(failure!);
      }
    } catch (e) {
      return Left(FailureModel(
          message: e.toString(), responseStatus: HttpResponseStatus.failure));
    }
  }
}
