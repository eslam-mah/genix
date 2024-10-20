import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_reponse_status.dart';

class ProfileService {
  Future<Either<FailureModel, Map>> updateProfile({
    File? profileImg,
    File? coverImg,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(PrefKeys.kToken); // Get token from cache

      if (token == null) {
        return Left(FailureModel(
          responseStatus: HttpResponseStatus.failure,
          message: 'Token not found',
        ));
      }

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('https://api.genix.social/api/accounts/me/profile'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      if (profileImg != null && await profileImg.exists()) {
        var mimeType =
            lookupMimeType(profileImg.path) ?? 'application/octet-stream';
        var mimeTypeData = mimeType.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'profile_img',
          profileImg.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ));
      }

      if (coverImg != null && await coverImg.exists()) {
        var mimeType =
            lookupMimeType(coverImg.path) ?? 'application/octet-stream';
        var mimeTypeData = mimeType.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'cover_img',
          coverImg.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ));
      }

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (responseBody.statusCode == 200 || responseBody.statusCode == 202) {
        return Right(json.decode(responseBody.body));
      } else {
        return Left(FailureModel(
          responseStatus: HttpResponseStatus.failure,
          message: 'Request failed with status: ${responseBody.statusCode}',
        ));
      }
    } catch (e) {
      return Left(FailureModel(
        responseStatus: HttpResponseStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
