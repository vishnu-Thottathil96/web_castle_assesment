class AuthRequest {
  final String deviceToken;
  final int deviceType;

  AuthRequest({
    required this.deviceToken,
    required this.deviceType,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest(
      deviceToken: json['device_token'] ?? '',
      deviceType: json['device_type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_token': deviceToken,
      'device_type': deviceType,
    };
  }
}
