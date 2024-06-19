import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class SettingRepository {
  Future<Either<FailureModel, Map>> getMyAccountDetails() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getMyAccount, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getAllTransactions() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getAllTransactions, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getAllPayouts() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getAllPayouts, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateMyAccount(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateMyAccount, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateGeneralSetting(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateGeneralSetting, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateMyPassword(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateMyPassword, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateMyEmails(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateMyEmail, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateStatus(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          linkUrl: ApiEndPoints.updateStatus, data: data, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateProfile(
      File profile, String name) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchFile(
          linkUrl: ApiEndPoints.updateMyAccountProfile,
          file: profile,
          name: name,
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteMyAccount() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteMyAccount, token: token);
    });
  }

  Future<Either<FailureModel, Map>> postPayout(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          linkUrl: ApiEndPoints.postPayout, data: data, token: token);
    });
  }
}
