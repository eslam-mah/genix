import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:genix/core/services/checkinternet.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_reponse_status.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpFileHelper {
  // Function to save token
  static Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('HttpHelper._saveToken: $token');
    await prefs.setString(PrefKeys.kToken, token);
  }

  // Function to get token
  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefKeys.kToken);
  }

  static Future<http.Response> patchProfile({
    required String linkUrl,
    String? token,
    File? profileImg,
    File? coverImg,
  }) async {
    token ??= await _getToken(); // Get token if not provided

    var request = http.MultipartRequest('POST', Uri.parse(linkUrl));

    // Set headers
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.headers['Content-Type'] = 'multipart/form-data';

    // Add the required '_method' field
    request.fields['_method'] = 'patch';

    // Add the profile_img if provided
    if (profileImg != null && await profileImg.exists()) {
      var profileImgMimeType =
          lookupMimeType(profileImg.path) ?? 'application/octet-stream';
      var profileImgMimeTypeData = profileImgMimeType.split('/');

      request.files.add(await http.MultipartFile.fromPath(
        'profile_img',
        profileImg.path,
        contentType:
            MediaType(profileImgMimeTypeData[0], profileImgMimeTypeData[1]),
      ));
    }

    // Add the cover_img if provided
    if (coverImg != null && await coverImg.exists()) {
      var coverImgMimeType =
          lookupMimeType(coverImg.path) ?? 'application/octet-stream';
      var coverImgMimeTypeData = coverImgMimeType.split('/');

      request.files.add(await http.MultipartFile.fromPath(
        'cover_img',
        coverImg.path,
        contentType:
            MediaType(coverImgMimeTypeData[0], coverImgMimeTypeData[1]),
      ));
    }

    // Log the request for debugging
    print("Sending PATCH request to $linkUrl with _method=patch");

    // Send the request and return the response
    final response = await request.send();

    // Parse and return the response
    return await http.Response.fromStream(response);
  }

  static Future<Either<FailureModel, Map>> handleRequestWithApiKey(
    Future<http.Response> Function(String apiKey) requestFunction,
    String apiKey,
  ) async {
    try {
      http.Response response = await requestFunction(apiKey);

      // Log the status code and response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 202) {
        return Right(jsonDecode(response.body));
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        String message = jsonDecode(response.body)['message'];
        return Left(FailureModel(
          responseStatus: HttpResponseStatus.invalidData,
          message: message,
        ));
      } else {
        String message = jsonDecode(response.body)['message'];
        return Left(FailureModel(
          responseStatus: HttpResponseStatus.failure,
          message: message,
        ));
      }
    } catch (e) {
      print('Exception occurred: $e');
      return Left(FailureModel(
          responseStatus: HttpResponseStatus.failure, message: e.toString()));
    }
  }

  static Future<Either<FailureModel, Map>> handleRequest(
    Future<http.Response> Function(String token) requestFunction,
  ) async {
    try {
      if (await isConnectedToInternet()) {
        String token = await _getToken() ?? "";
        http.Response response = await requestFunction(token);

        // Log the status code and response body for debugging
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 202) {
          return Right(jsonDecode(response.body));
        } else if (response.statusCode == 401 || response.statusCode == 400) {
          String message = jsonDecode(response.body)['message'];
          return Left(FailureModel(
            responseStatus: HttpResponseStatus.invalidData,
            message: message,
          ));
        } else {
          String message = jsonDecode(response.body)['message'];
          return Left(FailureModel(
            responseStatus: HttpResponseStatus.failure,
            message: message,
          ));
        }
      } else {
        return Left(
            FailureModel(responseStatus: HttpResponseStatus.noInternet));
      }
    } catch (e) {
      print('Exception occurred: $e');
      return Left(FailureModel(
          responseStatus: HttpResponseStatus.failure, message: e.toString()));
    }
  }
}
