class LoginResponse {
  final String? token;

  LoginResponse({this.token});

  factory LoginResponse.fromJson(Map<dynamic, dynamic> json) {
    return LoginResponse(
      token: json['data']['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'token': token,
      }
    };
  }
}
