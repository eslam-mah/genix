import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class TicketsRepository {
  Future<Either<FailureModel, Map>> getAllTicketsRepo() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getAllTickets, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getTicketByIdRepo({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getTicketById + "/$id", token: token);
    });
  }

  Future<Either<FailureModel, Map>> postTicket(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.postTicket, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateTicket(
      {required int id, required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateTicket + "/$id",
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateTicketStatus(
      {required int ticketId,
      required Map<String, dynamic> data,
      required String status}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl:
              ApiEndPoints.updateTicketStatus + "/$ticketId?status=$status",
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteTicket({
    required String id,
  }) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteTicket + "/$id", token: token);
    });
  }

  Future<Either<FailureModel, Map>> postTicketComment(
      {required int id, required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.postTicketComment + "/$id",
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateTicketComment(
      {required int id, required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateTicketComment + "/$id",
          data: data,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteTicketComment({
    required int id,
  }) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteTicketComment + "/$id", token: token);
    });
  }
}
