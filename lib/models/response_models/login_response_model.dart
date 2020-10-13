
/// Response from REST API from logging in
class LoginResponseModel{
  /// The users token
  final String _authToken;

  // Getter
  String get authToken => _authToken;

  LoginResponseModel(this._authToken);

  /// Create object from JSON data
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(json['auth_token']);
  }
}