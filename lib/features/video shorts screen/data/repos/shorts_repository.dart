import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class ShortsRepository {
  Future<Either<FailureModel, Map>> getShorts() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getShorts, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getSavedShorts({required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getSavedShorts + '/$uid', token: token);
    });
  }

  Future<Either<FailureModel, Map>> getPostedShorts({required int uid}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPostedShorts + '/$uid', token: token);
    });
  }

  Future<Either<FailureModel, Map>> searchShorts() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.searchShorts, token: token);
    });
  }

  Future<Either<FailureModel, Map>> addShort(
      {required File short, required String name}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postFile(
          linkUrl: ApiEndPoints.addShort,
          file: short,
          name: name,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateShort(
      {required File short, required String name, required String id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchFile(
          linkUrl: ApiEndPoints.updateShort + '/$id',
          file: short,
          name: name,
          token: token);
    });
  }
}
