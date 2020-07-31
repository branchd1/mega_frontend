import 'package:flutter/material.dart';

class LoginResponse{
  final String auth_token;

  LoginResponse({this.auth_token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      auth_token: json['auth_token']
    );
  }
}