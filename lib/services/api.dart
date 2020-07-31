import 'package:http/http.dart' as http;

import 'dart:convert';

class EmailExistsResponse{
  final bool exists;

  EmailExistsResponse({this.exists});

  factory EmailExistsResponse.fromJson(Map<String, dynamic> json) {
    return EmailExistsResponse(
      exists: json['exists'],
    );
  }
}

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

  Future<EmailExistsResponse> checkEmailExists(String email) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    Map<String, String> data = <String, String>{
      'email': email,
    };

    final http.Response _res = await this.post(
        'api/check_email',
        additionalHeaders: headers,
        data: data
    );

    if (_res.statusCode == 200){
      return EmailExistsResponse.fromJson(jsonDecode(_res.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}