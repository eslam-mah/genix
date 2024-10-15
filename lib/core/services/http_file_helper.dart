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

  static Future<http.Response> postContent({
    required String url,
    String? token,
    String? content,
    String? pageId,
    String? groupId,
    String? postingIn,
    List<File>? files,
    String? checkinLocation,
    String? pollQuestion,
    List<String>? pollOptions,
    String? eventTimestamp,
    String? microphoneId,
    String? cameraId,
    bool? cameraMirror,
    String? deviceType,
    bool? isLive,
    bool? toCloseFriends,
    bool? event,
    bool? poll,
    bool? checkin,
  }) async {
    token ??= await _getToken(); // Get token if not provided

    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Set headers
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.headers['Content-Type'] = 'multipart/form-data';

    // Add fields
    if (content != null) request.fields['content'] = content;
    if (pageId != null) request.fields['page_id'] = pageId;
    if (groupId != null) request.fields['group_id'] = groupId;
    if (postingIn != null) request.fields['posting_in'] = postingIn;
    if (checkinLocation != null)
      request.fields['checkin_location'] = checkinLocation;
    if (pollQuestion != null) request.fields['poll_question'] = pollQuestion;
    if (eventTimestamp != null)
      request.fields['event_timestamp'] = eventTimestamp;
    if (microphoneId != null) request.fields['microphone_id'] = microphoneId;
    if (cameraId != null) request.fields['camera_id'] = cameraId;
    if (cameraMirror != null)
      request.fields['camera_mirror'] = cameraMirror.toString();
    if (deviceType != null) request.fields['device_type'] = deviceType;
    if (isLive != null) request.fields['is_live'] = isLive.toString();
    if (toCloseFriends != null)
      request.fields['to_close_friends'] = toCloseFriends.toString();
    if (event != null) request.fields['event'] = event.toString();
    if (poll != null) request.fields['poll'] = poll.toString();
    if (checkin != null) request.fields['checkin'] = checkin.toString();

    // Add files if any
    if (files != null && files.isNotEmpty) {
      for (var file in files) {
        if (await file.exists()) {
          var fileMimeType =
              lookupMimeType(file.path) ?? 'application/octet-stream';
          var fileMimeTypeData = fileMimeType.split('/');
          request.files.add(await http.MultipartFile.fromPath(
            'files[]',
            file.path,
            contentType: MediaType(fileMimeTypeData[0], fileMimeTypeData[1]),
          ));
        }
      }
    }

    // Add poll options if any
    if (pollOptions != null && pollOptions.isNotEmpty) {
      for (int i = 0; i < pollOptions.length; i++) {
        request.fields['poll_options[$i]'] = pollOptions[i];
      }
    }

    // Send request and handle response
    final response = await request.send();
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
