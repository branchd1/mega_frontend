import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenStateModel {
  String _token;

  String get token => _token;

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

  void setToken(String token) async {
    _token = token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}