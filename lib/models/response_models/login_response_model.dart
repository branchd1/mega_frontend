import 'package:flutter/material.dart';

class LoginResponseModel{
  final String authToken;

  LoginResponseModel({this.authToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      authToken: json['auth_token']
    );
  }
}