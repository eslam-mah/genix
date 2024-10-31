import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_file_helper.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class SettingRepository {
  Future<Either<FailureModel, Map>> getMyAccountDetails() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getMyAccount, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getAllTransactions(
      {required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: '${ApiEndPoints.getAllTransactions}?page=$page',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getTransactionsById(
      {required int page, required String query}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: '${ApiEndPoints.getAllTransactions}?by=id&query=$query',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getTransactionsByName(
      {required int page, required String query}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: '${ApiEndPoints.getAllTransactions}?by=name&query=$query',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getAllPayouts() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getAllPayouts, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateAccountDetails(
      {required String showName,
      required String userName,
      required String email,
      required String bio,
      required String city,
      required String country,
      required String currentPassword,
      required String newPassword,
      required String payPalEmail,
      required String facebook,
      required String tiktok,
      required String instagram,
      required String x,
      required String pinterest,
      required String steam,
      required String linkedIn,
      required String gender,
      required File profileImg}) async {
    return await HttpFileHelper.handleRequest((token) async {
      return await HttpFileHelper.patchAccount(
          linkUrl: ApiEndPoints.updateMyAccount,
          token: token,
          socialTwitter: x,
          gender: gender,
          socialFacebook: facebook,
          socialInstagram: instagram,
          socialLinkedin: linkedIn,
          bio: bio,
          paypalEmail: payPalEmail,
          newPassword: newPassword,
          currentPassword: currentPassword,
          socialPinterest: pinterest,
          socialSteam: steam,
          socialTiktok: tiktok,
          profileImg: profileImg,
          showname: showName,
          username: userName,
          email: email,
          city: city,
          country: country);
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

  // Future<Either<FailureModel, Map>> updateProfile(
  //     {required Map<String, dynamic> data}) async {
  //   return await HttpHelper.handleRequest((token) async {
  //     return await HttpHelper.patchData(
  //         linkUrl: ApiEndPoints.updateMyAccountProfile,
  //         data: data,
  //         token: token);
  //   });
  // }
  Future<Either<FailureModel, Map>> updateProfile({
    File? profileImg,
    File? coverImg,
  }) async {
    return await HttpFileHelper.handleRequest((token) async {
      return await HttpFileHelper.patchProfile(
        linkUrl: ApiEndPoints.updateMyAccountProfile,
        token: token,
        profileImg: profileImg,
        coverImg: coverImg,
      );
    });
  }

  // Future<Either<FailureModel, Map>> updateProfile(
  //     {required File profile, String? name}) async {
  //   return await HttpHelper.handleRequest((token) async {
  //     return await HttpHelper.patchFile(
  //         linkUrl: ApiEndPoints.updateMyAccountProfile,
  //         file: profile,
  //         name: name ?? '',
  //         token: token);
  //   });
  // }

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
