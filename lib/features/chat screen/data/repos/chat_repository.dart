import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_helper.dart';
import 'package:genix/core/utils/api_end_points.dart';
import 'package:mime/mime.dart';

class ChatRepository {
  Future<Either<FailureModel, Map>> getChatRooms() async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(linkUrl: ApiEndPoints.chatRooms, token: token);
    });
  }

  Future<Either<FailureModel, Map>> getChatRoomMessagesById({required String id}) async {
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.getData(linkUrl: ApiEndPoints.chatRoomMessages + id, token: token);
    });
  }

  Future<Either<FailureModel, Map>> sendMessage({required String id, required String message, List<PlatformFile>? files}) async {
    List<MultipartFile> filesData = [];

    if (files != null) {
      for (var file in files) {
        if (file.path != null) {
          filesData.add(
            await MultipartFile.fromFile(
              file.path!, // File path
              filename: file.path!.split("/").last, // File name
              contentType: DioMediaType.parse(
                lookupMimeType(file.path!) ?? '',
              ), // Mime type
            ),
          );
        }
      }
    }
    return await HttpHelper.handleRequest((token) async {
      return await HttpHelper.postData(
        linkUrl: ApiEndPoints.chatRoomMessage + id,
        token: token,
        header: {
          'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
        },
        data: {
          "content": message,
          if (filesData.isNotEmpty) "files": filesData,
        },
      );
    });
  }
}
