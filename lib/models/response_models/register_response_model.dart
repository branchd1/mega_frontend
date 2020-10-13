
/// Response from REST API from registering
class RegisterResponseModel{
  /// The users username
  final dynamic _username;

  /// The users email
  final dynamic _email;

  /// The users password
  final dynamic _password;

  /// The users password repeated
  final dynamic _rePassword;

  // Getters
  dynamic get password => _password;
  dynamic get username => _username;
  dynamic get email => _email;
  dynamic get rePassword => _rePassword;

  RegisterResponseModel(this._username, this._email, this._password, this._rePassword);

  /// Create object from JSON data
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      json['username'],
      json['email'],
      json['password'],
      json['re_password'],
    );
  }

  /// Create object from error JSON data
  String errorToString() {
    if (_username != null && _username is List<dynamic>){
      return _username[0];
    } else if (_email != null && _email is List<dynamic>){
      return _email[0];
    } else if (_password != null && _password is List<dynamic>){
      return _password[0];
    } else {
      return null;
    }
  }
}