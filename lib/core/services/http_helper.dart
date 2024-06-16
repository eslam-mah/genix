import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:genix/core/services/checkinternet.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/core/services/http_reponse_status.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class HttpHelper {
  static Future<http.Response> postData({
    required String linkUrl,
    required Map data,
    required String? token,
  }) async {
    var headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var response = await http.post(
      Uri.parse(linkUrl),
      body: json.encode(data),
      headers: headers,
    );

    return _handleResponse(
        response, () => postData(linkUrl: linkUrl, data: data, token: token));
  }

  static Future<http.Response> getData({
    required String linkUrl,
    required String token,
  }) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var response = await http.get(Uri.parse(linkUrl), headers: headers);

    return _handleResponse(
        response, () => getData(linkUrl: linkUrl, token: token));
  }

  static Future<http.Response> putData({
    required String linkUrl,
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    var headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var response = await http.put(Uri.parse(linkUrl),
        body: json.encode(data), headers: headers);
    return _handleResponse(
        response, () => putData(linkUrl: linkUrl, data: data, token: token));
  }

  static Future<http.Response> patchData({
    required String linkUrl,
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    var headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };
    String jsonBody = json.encode(data);

    var response =
        await http.patch(Uri.parse(linkUrl), body: jsonBody, headers: headers);
    return _handleResponse(
        response, () => patchData(linkUrl: linkUrl, data: data, token: token));
  }

  static Future<http.Response> deleteData({
    required String linkUrl,
    Map? data,
    required String? token,
  }) async {
    var headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var response = await http.delete(Uri.parse(linkUrl),
        body: json.encode(data), headers: headers);
    return _handleResponse(
        response, () => deleteData(linkUrl: linkUrl, data: data, token: token));
  }

  static Future<http.Response> patchFile({
    required String linkUrl,
    required File file,
    required String name,
    required String? token,
  }) async {
    try {
      print("Attempting to upload file...");

      var request = http.MultipartRequest('PATCH', Uri.parse(linkUrl));
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      if (!await file.exists()) {
        throw Exception("File not found at path: ${file.path}");
      }

      var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      var mimeTypeData = mimeType.split('/');
      if (mimeTypeData.length != 2) {
        throw Exception("Invalid MIME type: $mimeType");
      }

      request.files.add(await http.MultipartFile.fromPath(
        name,
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

      final response = await request.send();
      final http.Response res = await http.Response.fromStream(response);
      var resFile = json.decode(res.body);

      print("Response Status: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${res.body}");

      if (response.statusCode != 202) {
        print("Failed to upload file: ${resFile['message']}");
      }

      return res;
    } catch (e) {
      print("Error in patchFile: $e");
      rethrow;
    }
  }

  static Future<http.Response> postFile({
    required String linkUrl,
    required File file,
    required String name,
    required String? token,
  }) async {
    try {
      print("Attempting to upload file...");

      var request = http.MultipartRequest('POST', Uri.parse(linkUrl));
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      if (!await file.exists()) {
        throw Exception("File not found at path: ${file.path}");
      }

      var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      var mimeTypeData = mimeType.split('/');
      if (mimeTypeData.length != 2) {
        throw Exception("Invalid MIME type: $mimeType");
      }

      request.files.add(await http.MultipartFile.fromPath(
        name,
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

      final response = await request.send();
      final http.Response res = await http.Response.fromStream(response);
      var resFile = json.decode(res.body);

      print("Response Status: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${res.body}");

      if (response.statusCode != 202) {
        print("Failed to upload file: ${resFile['message']}");
      }

      return res;
    } catch (e) {
      print("Error in postFile: $e");
      rethrow;
    }
  }

  static Future<Either<FailureModel, Map>> handleRequest(
    Future<http.Response> Function(String token) requestFunction,
  ) async {
    try {
      if (await isConnectedToInternet()) {
        String customToken = CacheData.getData(key: 'customToken') ?? "";

        print("customToken");
        print(customToken);

        http.Response response = await requestFunction(customToken);

        if (response.statusCode == 202) {
          print(
              "++++++++++Backend Response +++++++++++${jsonDecode(response.body)}");
          return Right(jsonDecode(response.body));
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          String message = jsonDecode(response.body)['message'];
          print('Error message: $message');
          if (response.statusCode == 401) {
            var newToken = await refreshToken();
            if (newToken != null) {
              await CacheData.setData(key: 'customToken', value: newToken);
              return handleRequest(requestFunction);
            } else {
              _handleLogout();
              return Left(FailureModel(
                  responseStatus: HttpResponseStatus.invalidData,
                  message: message));
            }
          } else {
            return Left(FailureModel(
                responseStatus: HttpResponseStatus.invalidData,
                message: message));
          }
        } else {
          String message = jsonDecode(response.body)['message'];
          print('Backend request error: $message');
          return Left(FailureModel(responseStatus: HttpResponseStatus.failure));
        }
      } else {
        return Left(
            FailureModel(responseStatus: HttpResponseStatus.noInternet));
      }
    } catch (e) {
      print("RequestHandler Error");
      print(e.toString());
      return Left(FailureModel(responseStatus: HttpResponseStatus.failure));
    }
  }

  static Future<http.Response> _handleResponse(
      http.Response response, Function retryRequest) async {
    if (response.statusCode == 401) {
      var newToken = await refreshToken();
      if (newToken != null) {
        await CacheData.setData(key: 'customToken', value: newToken);
        return await retryRequest();
      } else {
        _handleLogout();
      }
    }
    return response;
  }

  static Future<String?> refreshToken() async {
    try {
      var response = await http.post(
        Uri.parse("YOUR_REFRESH_TOKEN_ENDPOINT"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {'refresh_token': CacheData.getData(key: 'refreshToken')}),
      );

      if (response.statusCode == 202) {
        var data = jsonDecode(response.body);
        print("Token refreshed successfully.");
        return data['data']['token'];
      } else {
        print('Failed to refresh token, status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }

  static void _handleLogout() {
    // Clear the cached data
    CacheData.clearData();
    print("Token expired. Logging out...");
    // Navigate to login screen or handle logout logic
  }
}
