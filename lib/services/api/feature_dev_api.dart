import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/bars/error_snack_bar.dart';
import 'dart:convert';

import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/state_models/current_community_state_model.dart';
import 'package:mega/models/state_models/current_feature_state_model.dart';
import 'package:mega/services/api/base_api.dart';
import 'package:provider/provider.dart';

class FeatureDevAPI {
  static Future<http.Response> saveToDataStore(
      BuildContext context,
      {
        Map<String, String> data,
        String access,
        String tag,
        String featureKey
      }
    ) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    http.Response _res;

    data = {
      ...data,
      'mega\$tag': tag,
      'mega\$access': access != null ? access : 'user',
      'mega\$community': Provider.of<CurrentCommunityStateModel>(context, listen: false).currentCommunity.id.toString(),
      'mega\$feature': Provider.of<CurrentFeatureStateModel>(context, listen: false).currentFeature.key
    };

    try{
      _res = await BaseAPI.post(
          'api/data_store/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      return _res;
    } else if(_res.statusCode == 400) {
      showErrorSnackBar(context);
      return _res;
    } else {
      showErrorSnackBar(context);
      return _res;
    }
  }

  static Future<http.Response> getToDataStore(
      BuildContext context,
      {Map<String, String> params}
      ) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    http.Response _res;

    try{
      _res = await BaseAPI.get(
          'api/data_store/',
          additionalHeaders: headers,
          params: params
      );
    } on SocketException{
      showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      return _res;
    } else if(_res.statusCode == 400) {
      showErrorSnackBar(context);
      return _res;
    } else {
      showErrorSnackBar(context);
      return _res;
    }
  }

  static Future<http.Response> postExternal(
    BuildContext context,
    String url,
    String endpoint,
    {
      Map<String, String> data,
    }){

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    headers = {
      ...headers,
    };

    // add a trailing slash
    if(!endpoint.endsWith('/')) endpoint += '/';

    final Uri uri = Uri.http(url, endpoint);

    return http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> getExternal(
      BuildContext context,
      String url,
      String endpoint,
      {
        Map<String, String> params,
      }){

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    headers = {
      ...headers,
    };

    // add a trailing slash
    if(!endpoint.endsWith('/')) endpoint += '/';

    final Uri uri = Uri.http(url, endpoint, params);

    return http.get(
      uri,
      headers: headers,
    );
  }
}