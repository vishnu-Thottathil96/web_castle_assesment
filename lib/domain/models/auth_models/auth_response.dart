class AuthResponse {
  final int errorCode;
  final String message;
  final AuthData data;

  AuthResponse({
    required this.errorCode,
    required this.message,
    required this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      errorCode: json['error_code'] ?? 0,
      message: json['message'] ?? '',
      data: AuthData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error_code': errorCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AuthData {
  final String accessToken;

  AuthData({required this.accessToken});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['access_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
    };
  }
}
