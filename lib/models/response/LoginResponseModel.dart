import 'package:flutter/material.dart';

class LoginResponseModel{
  final String auth_token;

  LoginResponseModel({this.auth_token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      auth_token: json['auth_token']
    );
  }
}