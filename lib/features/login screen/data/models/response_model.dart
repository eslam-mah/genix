class LoginResponse {
  final String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<dynamic, dynamic> json) {
    return LoginResponse(
      token: json['data']['token'],
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
