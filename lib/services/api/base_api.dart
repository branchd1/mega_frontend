import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Base API methods
class BaseAPI {
  /// The backend URL
  static const String url = '0.0.0.0:9000';
//  static const String url = 'mega-app-project.herokuapp.com';

  /// Post request to server
  static Future<http.Response> post(
    String endpoint,
    {
      Map<String, String> data,
      Map<String, String> additionalHeaders
    }){

    // add headers
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    headers = {
      ...headers,
      if(additionalHeaders != null) ...additionalHeaders
    };

    // build uri
    final Uri uri = Uri.http(url, endpoint);

    // send post request
    return http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  /// Send delete request to server
  static Future<http.Response> delete(
      String endpoint,
      {
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

    return http.delete(
      uri,
      headers: headers,
    );
  }

  /// Send patch request to server
  static Future<http.Response> patch(
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

    return http.patch(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  /// Send get request to server
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

  /// Send multipart post request to server
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

    // get data keys
    List<String> _keys = data.keys.toList();

    // convert files to multipart files in data map
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

    // send streamed request
    http.StreamedResponse _res = await request.send();

    return _res;
  }

  /// Send multipart patch request to server
  static Future<http.StreamedResponse> multipartPatch (String endpoint,
      {
        @required List<String> mediaKeys,
        @required Map<String, String> data,
        Map<String, String> additionalHeaders
      }) async {

    final Uri uri = Uri.http(BaseAPI.url, endpoint);

    var request = new http.MultipartRequest("PATCH", uri);

    Map<String, String> headers = <String, String>{
      'Content-Type': 'multipart/form-data',
      ...additionalHeaders
    };

    request.headers.addAll(headers);

    List<String> _keys = data.keys.toList();

    // convert files to multipart files in data map
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