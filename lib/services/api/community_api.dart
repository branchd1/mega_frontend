import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/bars/error_snack_bar.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/response_models/create_community_response_model.dart';
import 'package:mega/models/response_models/join_community_response_model.dart';
import 'package:mega/services/callback_types.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

import 'base_api.dart';

class CommunityAPI {
  static Future<List<CommunityModel>> getCommunities(BuildContext context) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    http.Response _res;

    try{
      _res = await BaseAPI.get(
        'api/communities/',
        additionalHeaders: headers,
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      final Map<String, dynamic> _resBody = jsonDecode(_res.body);
      List<dynamic> _communitiesDynamicList = _resBody['results'];

      List<CommunityModel> _communities = _communitiesDynamicList.map((item) => CommunityModel.fromJson(item)).toList();
      return _communities;
    } else if(_res.statusCode == 400) {
      showErrorSnackBar(context);
      return null;
    } else {
      showErrorSnackBar(context);
      return null;
    }
  }

  static Future<bool> joinCommunities(BuildContext context, String communityKey,
      SetErrorTextCallback setErrorText) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    Map<String, String> data = <String, String>{
      'key': communityKey,
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
        'api/communities/join/',
        additionalHeaders: headers,
        data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      return true;
    } else if(_res.statusCode == 400) {
      setErrorText(
        JoinCommunityResponseModel.fromJson(jsonDecode(_res.body)).errorToString()
      );
      return false;
    } else {
      showErrorSnackBar(context);
      return false;
    }
  }

  static Future<CreateCommunityResponseModel> createCommunity(BuildContext context, String communityName, String communityType, SetErrorTextCallback setErrorText) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    Map<String, String> data = <String, String>{
      'name': communityName,
      'type': communityType
    };

    http.Response _res;

    try{
      _res = await BaseAPI.post(
        'api/communities/',
        additionalHeaders: headers,
        data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==201){
      return CreateCommunityResponseModel.fromJson(jsonDecode(_res.body));
    } else if(_res.statusCode == 400) {
      setErrorText(
          CreateCommunityResponseModel.fromJson(jsonDecode(_res.body)).errorToString()
      );
      return null;
    } else {
      showErrorSnackBar(context);
      return null;
    }
  }
}