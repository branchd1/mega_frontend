import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/ErrorSnackBar.dart';
import 'package:mega/models/AuthTokenModel.dart';
import 'package:mega/models/CommunityModel.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

import 'BaseAPI.dart';

class CommunityAPI {
  static Future<List<CommunityModel>> getCommunities(BuildContext context) async {

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ' + Provider.of<AuthTokenModel>(context).token
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
}