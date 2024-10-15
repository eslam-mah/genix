import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_file_helper.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class PagesRepository {
  Future<Either<FailureModel, Map>> getPagesList() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPagesList, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getPageById({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPage + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> createPage(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          data: data, linkUrl: ApiEndPoints.createPage, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updatePageDetails(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          data: data,
          linkUrl: ApiEndPoints.updatePageDetails + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> updatePageProfile(
      {File? coverImg, File? profileImg, required int id}) async {
    return await HttpFileHelper.handleRequest((token) async {
      return await HttpFileHelper.patchProfile(
          coverImg: coverImg,
          profileImg: profileImg,
          linkUrl: ApiEndPoints.updatePageProfile + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deletePage({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deletePage + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> postPageRating(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          data: data,
          linkUrl: ApiEndPoints.postRateOnPage + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getPagePhotos({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getPagePhotos + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> followPage(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          data: data,
          linkUrl: ApiEndPoints.followPagePost + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> removeFollowPage({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.removePageFollow + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> postPageInvitation(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          data: data,
          linkUrl: ApiEndPoints.postPageInvitations + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> updatePageInvitation(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          data: data, linkUrl: ApiEndPoints.updatePageInvitation, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getPageMembers({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getAllPagesMembers + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> updatePageMember(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          data: data,
          linkUrl: ApiEndPoints.updatePageMember + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deletePageMember({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deletePageMember + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> deletePageMemberPost(
      {required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deletePageMemberPost + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> deletePageMemberComment(
      {required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deletePageMemberComment + '/$id', token: token);
    });
  }
}
