import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/ErrorSnackBar.dart';
import 'dart:convert';

import 'package:mega/models/EmailExistsResponseModel.dart';
import 'package:mega/models/LoginResponseModel.dart';
import 'package:mega/models/RegisterResponseModel.dart';

typedef void SetErrorTextCallback(String text);

class API {
  static const String url = 'http://0.0.0.0:9000/';

  static Future<http.Response> post(String endpoint, {Map<String, String> data, Map<String, String> additionalHeaders}){
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

  static Future<EmailExistsResponseModel> checkEmailExists(BuildContext context, String email) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    Map<String, String> data = <String, String>{
      'email': email,
    };

    http.Response _res;

    try{
      _res = await API.post(
          'api/check_email/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode == 200){
      return EmailExistsResponseModel.fromJson(jsonDecode(_res.body));
    } else {
      showErrorSnackBar(context);
      return null;
    }
  }

  static Future<LoginResponseModel> login(BuildContext context, String email, String password, SetErrorTextCallback setErrorText) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    Map<String, String> data = <String, String>{
      'username': email,
      'password': password
    };

    http.Response _res;

    try{
      _res = await API.post(
          'auth/token/login/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode == 200){
      return LoginResponseModel.fromJson(jsonDecode(_res.body));
    } else if(_res.statusCode == 400) {
      setErrorText('Invalid email/password');
      return null;
    } else {
      showErrorSnackBar(context);
      return null;
    }
  }

  static Future<RegisterResponseModel> register(BuildContext context, String email, String password, SetErrorTextCallback setErrorText) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    Map<String, String> data = <String, String>{
      'email': email,
      'username': email,
      'password': password,
      're_password': password
    };

    http.Response _res;

    try{
      _res = await API.post(
          'auth/users/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==201){
      return RegisterResponseModel.fromJson(jsonDecode(_res.body));
    } else if(_res.statusCode == 400) {
      setErrorText(
          RegisterResponseModel.fromJson(jsonDecode(_res.body))
          .errorToString()
      );
      return null;
    } else {
      showErrorSnackBar(context);
      return null;
    }
  }
}