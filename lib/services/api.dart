import 'package:http/http.dart' as http;

import 'dart:convert';

class API {
  static const String url = 'http://0.0.0.0:9000/';

  Future<http.Response> post(String endpoint, {Map<String, String> data, Map<String, String> additionalHeaders}){
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    headers = {
      ...headers,
      ...additionalHeaders
    };

    return http.post(
      url + endpoint,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  Future<http.Response> checkEmailExists(String email){
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    Map<String, String> data = <String, String>{
      'email': email,
    };

    return this.post(
        'api/check_email',
        additionalHeaders: headers,
        data: data
    );
  }
}