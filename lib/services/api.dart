import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/ErrorSnackBar.dart';
import 'dart:convert';

import 'package:mega/models/EmailExistsResponse.dart';
import 'package:mega/models/LoginResponse.dart';


class API {
  static const String url = 'http://0.0.0.0:9000/';

  final BuildContext context;

  API({this.context});

  Future<http.Response> post(String endpoint, {Map<String, String> data, Map<String, String> additionalHeaders}){
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    headers = {
      ...headers,
      ...additionalHeaders
    };

    return http.post(
      url + endpoint,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  Future<EmailExistsResponse> checkEmailExists(String email) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    Map<String, String> data = <String, String>{
      'email': email,
    };

    http.Response _res;

    try{
      _res = await this.post(
          'api/check_email/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    return EmailExistsResponse.fromJson(jsonDecode(_res.body));
  }

  Future<LoginResponse> login(String email, String password) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    Map<String, String> data = <String, String>{
      'username': email,
      'password': password
    };

    http.Response _res;

    try{
      _res = await this.post(
          'auth/token/login/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    return LoginResponse.fromJson(jsonDecode(_res.body));
  }
}