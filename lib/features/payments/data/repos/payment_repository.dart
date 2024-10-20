import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class PaymentRepository {
  Future<Either<FailureModel, Map>> createStripe(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.createStripePayment, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getPromotions() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPromotions, token: token);
    });
  }

  Future<Either<FailureModel, Map>> addPromotion(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.postPromotion, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getCpvRate() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPromotionCpvRate, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getPromotionById({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: '${ApiEndPoints.getPromotionById}/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> getGifts() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getGifts, token: token);
    });
  }
}
