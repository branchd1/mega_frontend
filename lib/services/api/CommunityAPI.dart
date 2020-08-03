import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/bars/ErrorSnackBar.dart';
import 'package:mega/models/AuthTokenModel.dart';
import 'package:mega/models/CommunityModel.dart';
import 'package:mega/models/response/JoinCommunityResponseModel.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

import 'BaseAPI.dart';

class CommunityAPI {
  static Future<List<CommunityModel>> getCommunities(BuildContext context) async {

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ' + Provider.of<AuthTokenModel>(context, listen: false).token
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
      'Content-Type': 'application/json',
      'Authorization': 'Token ' + Provider.of<AuthTokenModel>(context, listen: false).token
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
}