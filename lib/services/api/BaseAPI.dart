import 'package:http/http.dart' as http;
import 'dart:convert';

typedef void SetErrorTextCallback(String text);

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
      ...additionalHeaders
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
      ...additionalHeaders
    };

    final Uri uri = Uri.http(url, endpoint, params);

    return http.get(
      uri,
      headers: headers,
    );
  }
}