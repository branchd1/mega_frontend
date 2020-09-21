import 'package:shared_preferences/shared_preferences.dart';

/// Stores the current user auth token
class AuthTokenStateModel {
  /// The auth token
  String _token;

  // Getter
  String get token => _token;

  /// Check if a user has logged in on the app before
  /// If yes, get the users token from the mobile memory
  /// else, get the users token save in current app session
  Future<String> checkAndGetToken() async {
    if(_token == null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _savedToken = prefs.getString('auth_token');

      if(_savedToken != null){
        setToken(_savedToken);
      }
    }

    return _token;
  }

  /// Clear the token state and
  /// remove it from memory
  void clearToken() async {
    _token = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');
  }

  /// Set the token in the app state and app memory
  void setToken(String token) async {
    _token = token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}