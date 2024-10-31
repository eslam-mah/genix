import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/payments/data/repos/payment_service.dart';

class StripeRepo {
  StripeRepo();
  final PaymentService paymentService = PaymentService();
  Future<Either<FailureModel, String>> createStripe(
      {required Map<String, dynamic> data}) async {
    return await paymentService.createStripePayment(data: data);
  }
}
