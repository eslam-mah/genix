import 'package:genix/core/services/http_reponse_status.dart';

class FailureModel {
  String? message;
  HttpResponseStatus responseStatus;
  FailureModel({required this.responseStatus, this.message});
}
