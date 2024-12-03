import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/api_end_points.dart';
import 'package:http/http.dart' as http;

class Auth2FAService {
  final String baseUrl = ApiEndPoints.enableTwoFactorAuthentication;

  Future<Map<String, dynamic>> enableTwoFactorAuth(String authToken) async {
    final url = Uri.parse(baseUrl);
    final headers = {
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 202) {

        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to enable two-factor authentication: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
