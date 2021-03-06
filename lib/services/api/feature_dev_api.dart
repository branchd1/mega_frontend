import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mega/components/bars/error_snack_bar.dart';
import 'package:path/path.dart';

import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/state_models/current_community_state_model.dart';
import 'package:mega/models/state_models/current_feature_state_model.dart';
import 'package:mega/services/api/base_api.dart';
import 'package:provider/provider.dart';

/// Methods related to feature development API
class FeatureDevAPI {
  /// Save data to server data store
  static Future<Map<String, dynamic>> saveToDataStore(
      BuildContext context,
      {
        Map<String, String> data,
        String access,
        String tag
      }
    ) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    http.Response _res;

    // form the data using Mega's syntax
    data = {
      if (data != null) ...data,
      'mega\$tag': tag,
      'mega\$access': access != null ? access : 'user',
      'mega\$community': Provider.of<CurrentCommunityStateModel>(context, listen: false).currentCommunity.id.toString(),
      'mega\$feature': Provider.of<CurrentFeatureStateModel>(context, listen: false).currentFeature.key
    };

    try{
      _res = await BaseAPI.post(
          'api/data-store/',
          additionalHeaders: headers,
          data: data
      );
    } on SocketException{
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==201){
      Map<String, dynamic> _finalRes = jsonDecode(_res.body);
      return _finalRes;
    } else if(_res.statusCode == 400) {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    }
  }

  /// Get data from data store
  static Future<List<dynamic>> getToDataStore(
      BuildContext context,
      {
        Map<String, String> params,
        String tag
      }
      ) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    http.Response _res;

    params = {
      if (params != null) ...params,
      'mega\$tag': tag,
      'mega\$community': Provider.of<CurrentCommunityStateModel>(context, listen: false).currentCommunity.id.toString(),
      'mega\$feature': Provider.of<CurrentFeatureStateModel>(context, listen: false).currentFeature.key
    };

    try{
      _res = await BaseAPI.get(
          'api/data-store/',
          additionalHeaders: headers,
          params: params
      );
    } on SocketException{
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      List<dynamic> _finalRes = jsonDecode(_res.body);
      return _finalRes;
    } else if(_res.statusCode == 400) {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return null;
    }
  }

  /// upload image to datastore
  static Future<String> uploadImageToDataStore(BuildContext fileContext, File image) async {

    final String endpoint = 'api/upload-img/';

    final stream = new http.ByteStream(image.openRead());
    final length = await image.length();

    final Uri uri = Uri.https(BaseAPI.url, endpoint);

    var request = new http.MultipartRequest("POST", uri);

    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(fileContext, listen: false).token
    };

    request.headers.addAll(headers);

    var multipartFile = new http.MultipartFile('file', stream.cast(), length, filename: basename(image.path));

    request.files.add(multipartFile);

    http.StreamedResponse _res = await request.send();

    final String _resStr = await _res.stream.bytesToString();

    return jsonDecode(_resStr)['url'];
  }

  /// delete data from datastore
  static Future<bool> deleteFromDataStore(
      BuildContext context,
      {
        String storeId
      }
      ) async {

    Map<String, String> headers = <String, String>{
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(context, listen: false).token
    };

    http.Response _res;

    try{
      _res = await BaseAPI.delete(
          'api/data-store/delete/' + storeId + '/',
          additionalHeaders: headers,
      );
    } on SocketException{
      ErrorSnackBar.showErrorSnackBar(context);
    } catch (e) {
      print(e);
    }

    if(_res.statusCode==200){
      return true;
    } else if(_res.statusCode == 400) {
      ErrorSnackBar.showErrorSnackBar(context);
      return false;
    } else {
      ErrorSnackBar.showErrorSnackBar(context);
      return false;
    }
  }
}