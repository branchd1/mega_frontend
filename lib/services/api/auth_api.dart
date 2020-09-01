import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/bars/error_snack_bar.dart';
import 'dart:convert';

import 'package:mega/models/response_models/email_exists_response_model.dart';
import 'package:mega/models/response_models/login_response_model.dart';
import 'package:mega/models/response_models/register_response_model.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/services/callback_types.dart';
import 'package:provider/provider.dart';

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
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode == 200){
      return EmailExistsResponseModel.fromJson(jsonDecode(_res.body));
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
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
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode == 200){
      return LoginResponseModel.fromJson(jsonDecode(_res.body));
    } else if(_res.statusCode == 400) {
      setErrorText('Invalid email/password');
      return null;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
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
      ErrorSnackBar.showErrorSnackBar(context);
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
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    }
  }

  static Future<bool> resetPassword(
      BuildContext context,
      String email) async {

    Map<String, String> data = <String, String>{
      'email': email,
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
        'auth/users/reset_password/',
        data: data
      );
    } catch (e) {
      print(e);
    }

    if(_res.statusCode == 204){
      return true;
    } else {
      return false;
    }
  }

  static Future<UserModel> getUser(BuildContext context) async {

    http.Response _res;
    http.Response _res2;

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    try{
      _res = await BaseAPI.get(
        'accounts/users/me/',
        additionalHeaders: headers
      );
    } catch (e) {
      print(e);
    }

    try{
      _res2 = await BaseAPI.get(
        'api/profiles/',
        additionalHeaders: headers
      );
    } catch (e) {
      print(e);
    }

    if(_res.statusCode == 200 && _res2.statusCode == 200){

      int profileId = jsonDecode(_res2.body)[0]['id'];

      Map<String, dynamic> _userModel = {
        ...jsonDecode(_res2.body)[0],
        ...jsonDecode(_res.body),
        'profileId': profileId
      };

      return UserModel.fromJson(_userModel);
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    }
  }

  static Future<bool> patchUser(
      BuildContext context,
      {
        String firstName,
        String lastName,
        String phoneNumber,
        String picturePath,
        int profileId
      }
      ) async {

    http.Response _res;
    http.StreamedResponse _res2;

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    Map<String, String> _userData = <String, String>{
      'first_name': firstName,
      'last_name': lastName,
    };

    Map<String, String> _profileData = <String, String>{
      'phone_number': phoneNumber,
      if (picturePath != '') 'picture': picturePath,
    };

    try{
      _res = await BaseAPI.patch(
        'accounts/users/me/',
        data: _userData,
        additionalHeaders: headers
      );
    } catch (e) {
      print(e);
    }

    try{
      _res2 = await BaseAPI.multipartPatch(
        'api/profiles/' + profileId.toString() + '/',
        data: _profileData,
        mediaKeys: ['picture'],
        additionalHeaders: headers
      );
    } catch (e) {
      print(e);
    }

    if(_res.statusCode == 200 && _res2.statusCode == 200){
      return true;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return false;
    }
  }
}