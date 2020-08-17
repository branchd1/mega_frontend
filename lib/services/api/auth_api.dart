import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/bars/error_snack_bar.dart';
import 'dart:convert';

import 'package:mega/models/response_models/email_exists_response_model.dart';
import 'package:mega/models/response_models/login_response_model.dart';
import 'package:mega/models/response_models/register_response_model.dart';
import 'package:mega/services/custom_types.dart';

import 'base_api.dart';

class AuthAPI {
  static Future<EmailExistsResponseModel> checkEmailExists(BuildContext context, String email) async {

    Map<String, String> data = <String, String>{
      'email': email,
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
        'api/check_email/',
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

  static Future<LoginResponseModel> login(
    BuildContext context,
    String email,
    String password,
    {SetErrorTextCallback setErrorText}) async {

    Map<String, String> data = <String, String>{
      'username': email,
      'password': password
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
          'auth/token/login/',
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

  static Future<RegisterResponseModel> register(
    BuildContext context,
    String email,
    String password,
    SetErrorTextCallback setErrorText) async {

    Map<String, String> data = <String, String>{
      'email': email,
      'username': email,
      'password': password,
      're_password': password
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
        'auth/users/',
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