import 'package:flutter/foundation.dart';

class AuthTokenStateModel {
  String _token;

  String get token => _token;

  void setToken(String token){
    _token = token;
  }
}