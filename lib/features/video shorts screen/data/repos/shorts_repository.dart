import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_file_helper.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class ShortsRepository {
  Future<Either<FailureModel, Map>> getShorts({required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      final linkWithPage = '${ApiEndPoints.getShorts}?page=$page';
      return await HttpHelper.getData(
        linkUrl: linkWithPage,
        token: token,
      );
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
      {required File file, required String content}) async {
    return await HttpFileHelper.handleRequest((token) async {
      return await HttpFileHelper.postShort(
          url: ApiEndPoints.addShort,
          token: token,
          file: file,
          content: content);
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
