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

class HttpHelper {
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

  // Function to handle login and store token
  static Future<Either<FailureModel, Map>> login({
    required String linkUrl,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(linkUrl),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 202) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          final token = responseBody['data']['token'];
          await _saveToken(token); // Save token
          print('Token stored successfully');
          return Right(responseBody);
        } else {
          return Left(FailureModel(
            responseStatus: HttpResponseStatus.invalidData,
            message: responseBody['message'],
          ));
        }
      } else {
        return Left(FailureModel(
          responseStatus: HttpResponseStatus.failure,
          message: 'Request failed with status: ${response.statusCode}',
        ));
      }
    } catch (e) {
      return Left(FailureModel(
        responseStatus: HttpResponseStatus.failure,
        message: e.toString(),
      ));
    }
  }

  static Future<http.Response> postData({
    required String linkUrl,
    required Map data,
    String? token,
  }) async {
    token ??= await _getToken(); // Get token if not provided
    var headers = {
      'Authorization': 'Bearer $token',
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      Uri.parse(linkUrl),
      body: json.encode(data),
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> getData({
    required String linkUrl,
    String? token,
  }) async {
    token ??= await _getToken(); // Get token if not provided
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    var response = await http.get(Uri.parse(linkUrl), headers: headers);

    return response;
  }

  static Future<http.Response> putData({
    required String linkUrl,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    token ??= await _getToken(); // Get token if not provided
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    var response = await http.put(
      Uri.parse(linkUrl),
      body: json.encode(data),
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> patchData({
    required String linkUrl,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    token ??= await _getToken(); // Get token if not provided
    var headers = {
      'Authorization': 'Bearer $token',
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var response = await http.patch(
      Uri.parse(linkUrl),
      body: json.encode(data),
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> deleteData({
    required String linkUrl,
    Map? data,
    String? token,
  }) async {
    token ??= await _getToken(); // Get token if not provided
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    var response = await http.delete(
      Uri.parse(linkUrl),
      body: data,
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> patchFile({
    required String linkUrl,
    required File file,
    required String name,
    String? token,
  }) async {
    token ??= await _getToken(); // Get token if not provided
    var request = http.MultipartRequest('PATCH', Uri.parse(linkUrl));
    request.headers['Authorization'] = 'Bearer $token';

    if (!await file.exists()) {
      throw Exception("File not found at path: ${file.path}");
    }

    var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    var mimeTypeData = mimeType.split('/');

    request.files.add(await http.MultipartFile.fromPath(
      name,
      file.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    ));

    final response = await request.send();
    return await http.Response.fromStream(response);
  }

  static Future<http.Response> postMultipartData({
    required String linkUrl,
    required Map<String, dynamic> data,
    required List<File> files, // List of files
    required String name, // The name of the file field in the form
    String? token,
  }) async {
    token ??= await _getToken(); // Get token if not provided

    var request = http.MultipartRequest('POST', Uri.parse(linkUrl));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    // Add other data fields to the multipart request
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Attach files to the request
    for (int i = 0; i < files.length; i++) {
      File file = files[i];

      if (!await file.exists()) {
        throw Exception("File not found at path: ${file.path}");
      }

      var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      var mimeTypeData = mimeType.split('/');

      // Attach the file with the correct field name (e.g., `files.0`, `files.1`)
      request.files.add(await http.MultipartFile.fromPath(
        'files.$i', // Use 'files.0', 'files.1' etc.
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));
    }

    final response = await request.send();
    return await http.Response.fromStream(response);
  }

  static Future<http.Response> postFile({
    required String linkUrl,
    required File file,
    required String name,
    String? token,
  }) async {
    token ??= await _getToken(); // Get token if not provided
    var request = http.MultipartRequest('POST', Uri.parse(linkUrl));
    request.headers['Authorization'] = 'Bearer $token';

    if (!await file.exists()) {
      throw Exception("File not found at path: ${file.path}");
    }

    var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    var mimeTypeData = mimeType.split('/');

    request.files.add(await http.MultipartFile.fromPath(
      name,
      file.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    ));

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
