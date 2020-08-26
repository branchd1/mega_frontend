import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

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

  static Future<http.StreamedResponse> multipartPost (String endpoint,
    {
      @required List<String> mediaKeys,
      @required Map<String, String> data,
      Map<String, String> additionalHeaders
    }) async {

    final Uri uri = Uri.http(BaseAPI.url, endpoint);

    var request = new http.MultipartRequest("POST", uri);

    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data',
      ...additionalHeaders
    };

    request.headers.addAll(headers);

    List<String> _keys = data.keys.toList();

    for(String _key in _keys){
      if(mediaKeys.contains(_key)){
        String _imagePath = data[_key];
        final http.MultipartFile _multipartFile = await http.MultipartFile.fromPath(
            _key,
            _imagePath
        );
        request.files.add(_multipartFile);
      } else {
        request.fields[_key] = data[_key];
      }
    }

    http.StreamedResponse _res = await request.send();

    return _res;
  }
}