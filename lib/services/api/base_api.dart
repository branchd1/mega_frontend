import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class BaseAPI {
  static const String url = '0.0.0.0:9000';

  static Future<http.Response> post(
    String endpoint,
    {
      Map<String, String> data,
      Map<String, String> additionalHeaders
    }){

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    headers = {
      ...headers,
      if(additionalHeaders != null) ...additionalHeaders
    };

    final Uri uri = Uri.http(url, endpoint);

    return http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> get(
      String endpoint,
      {
        Map<String, String> params,
        Map<String, String> additionalHeaders
      }){

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    headers = {
      ...headers,
      if(additionalHeaders != null) ...additionalHeaders
    };

    final Uri uri = Uri.http(url, endpoint, params);

    return http.get(
      uri,
      headers: headers,
    );
  }

  static Future<String> uploadImageToDataStore(BuildContext fileContext, File image) async {

    final String endpoint = 'api/upload_img/';

    final stream = new http.ByteStream(image.openRead());
    final length = await image.length();

    final Uri uri = Uri.http(url, endpoint);

    var request = new http.MultipartRequest("POST", uri);

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ' + Provider.of<AuthTokenStateModel>(fileContext, listen: false).token
    };

    request.headers.addAll(headers);

    var multipartFile = new http.MultipartFile('file', stream.cast(), length, filename: basename(image.path));

    request.files.add(multipartFile);

    http.StreamedResponse _res = await request.send();

    final String _resStr = await _res.stream.bytesToString();

    return jsonDecode(_resStr)['url'];
  }
}