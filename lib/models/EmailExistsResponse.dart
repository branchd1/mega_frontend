import 'package:flutter/material.dart';

class EmailExistsResponse{
  final bool exists;

  EmailExistsResponse({this.exists});

  factory EmailExistsResponse.fromJson(Map<String, dynamic> json) {
    return EmailExistsResponse(
      exists: json['exists'],
    );
  }
}