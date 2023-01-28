interface class LoginResponse {
  final String refreshedToken;
  final String token;
  final String message;

  const LoginResponse({
    required this.refreshedToken,
    required this.token,
    required this.message,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      refreshedToken: map['refreshToken']?.toString() ?? '',
      token: map['token']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
    );
  }
}
