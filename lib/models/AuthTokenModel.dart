
import 'package:flutter/foundation.dart';

class AuthTokenModel extends ChangeNotifier{
  String _token;

  void setToken(String token){
    _token = token;
    notifyListeners();
  }
}