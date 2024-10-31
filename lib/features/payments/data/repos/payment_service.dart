import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/services/http_reponse_status.dart';
import 'package:genix/core/utils/api_end_points.dart';

class PaymentService {
  Future<Either<FailureModel, String>> createStripePayment(
      {required Map<String, dynamic> data}) async {
    final response = await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
        linkUrl: ApiEndPoints.createStripePayment,
        data: data,
        token: token,
      );
    });

    return response.fold(
      (failure) => Left(failure),
      (response) {
        final clientSecret = response['data']?['client_secret'];
        if (clientSecret != null) {
          return Right(clientSecret);
        } else {
          return Left(FailureModel(
              message: 'Client secret not found',
              responseStatus: HttpResponseStatus.failure));
        }
      },
    );
  }
}
