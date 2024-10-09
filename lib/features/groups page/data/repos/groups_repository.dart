import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_file_helper.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';

class GroupsRepository {
  Future<Either<FailureModel, Map>> getGroupsList() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getGroupsList, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getGroupById({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getGroup + '/$id', token: token);
    });
  }

  Future<Either<FailureModel, Map>> createGroup(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
          data: data, linkUrl: ApiEndPoints.createGroup, token: token);
    });
  }

  Future<Either<FailureModel, Map>> updateGroupDetails(
      {required Map<String, dynamic> data, required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.patchData(
          data: data,
          linkUrl: ApiEndPoints.updateGroupDetails + '/$id',
          token: token);
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

  Future<Either<FailureModel, Map>> getGroupMembers({required int id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(
          linkUrl: ApiEndPoints.getAllMembers + '/$id', token: token);
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
