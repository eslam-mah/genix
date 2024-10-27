import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_file_helper.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class GroupsRepository {
  Future<Either<FailureModel, Map>> getGroupsList({required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getGroupsList + '?page=$page', token: token);
    });
  }

  Future<Either<FailureModel, Map>> getGroupById({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getGroup + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> createGroup({
    required String name,
    required String category,
    required String website,
    required String about,
    required String facebook,
    required String tiktok,
    required String x,
    required String instagram,
    required String pinterest,
    required bool isPrivate,
    required String steam,
    required String linkedin,
    required File profileImg,
    required File coverImg,
  }) async {
    return await HttpFileHelper.handleRequest((token) async {
      return await HttpFileHelper.createGroupOrPage(
          url: ApiEndPoints.createGroup,
          token: token,
          name: name,
          category: category,
          website: website,
          about: about,
          socialFacebook: facebook,
          socialTiktok: tiktok,
          isPrivate: isPrivate,
          socialInstagram: instagram,
          socialTwitter: x,
          socialSteam: steam,
          socialPinterest: pinterest,
          socialLinkedin: linkedin,
          profileImg: profileImg,
          coverImg: coverImg);
    });
  }

  Future<Either<FailureModel, Map>> updateGroupDetails({
    required int id,
    required String name,
    required String category,
    required String website,
    required String about,
    required String facebook,
    required String tiktok,
    required String x,
    required String instagram,
    required String pinterest,
    required String steam,
    required String linkedin,
    required bool isPrivate,
    required File profileImg,
    required File coverImg,
  }) async {
    return await HttpFileHelper.handleRequest((token) async {
      return await HttpFileHelper.patchGroupOrPage(
          url: ApiEndPoints.updateGroupDetails + '/$id',
          token: token,
          name: name,
          category: category,
          website: website,
          isPrivate: isPrivate,
          about: about,
          socialFacebook: facebook,
          socialTiktok: tiktok,
          socialInstagram: instagram,
          socialTwitter: x,
          socialSteam: steam,
          socialPinterest: pinterest,
          socialLinkedin: linkedin,
          profileImg: profileImg,
          coverImg: coverImg);
    });
  }

  Future<Either<FailureModel, Map>> updateGroupProfile(
      {File? coverImg, File? profileImg, required int id}) async {
    return await HttpFileHelper.handleRequest((token) async {
      return await HttpFileHelper.patchProfile(
          coverImg: coverImg,
          profileImg: profileImg,
          linkUrl: ApiEndPoints.updateGroupProfile + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteGroup({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteGroup + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> postGroupRating(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          data: data,
          linkUrl: ApiEndPoints.postRateOnGroup + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> getGroupPhotos({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getGroupPhotos + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> joinGroup(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          data: data,
          linkUrl: ApiEndPoints.joinGroupPost + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> removeJoinGroup({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.removeJoin + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> postGroupInvitation(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          data: data,
          linkUrl: ApiEndPoints.postGroupInvitations + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateGroupInvitation(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          data: data, linkUrl: ApiEndPoints.updateInvitation, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getGroupMembers(
      {required int id, required int page}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getAllMembers + '/$id?page=$page',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateGroupMember(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          data: data,
          linkUrl: ApiEndPoints.updateGroupMember + '/$id',
          token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteGroupMember({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteGroupMember + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteGroupMemberPost(
      {required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteGroupMemberPost + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> deleteGroupMemberComment(
      {required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.deleteData(
          linkUrl: ApiEndPoints.deleteGroupMemberComment + '/$id',
          token: token);
    });
  }
}
