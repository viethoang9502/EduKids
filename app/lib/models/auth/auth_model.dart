class AuthModel {
  final String tokenType;
  final int id;
  final String username;
  final List<String> roles;
  final String message;
  final String token;
  final String refreshToken;

  AuthModel({
    required this.tokenType,
    required this.id,
    required this.username,
    required this.roles,
    required this.message,
    required this.token,
    required this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      tokenType: json['tokenType'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      username: json['username'] as String? ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      message: json['message'] as String? ?? '',
      token: json['token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
    );
  }
}
