import 'package:flutter/material.dart';

class EmailExistsResponseModel{
  final bool exists;

  EmailExistsResponseModel({this.exists});

  factory EmailExistsResponseModel.fromJson(Map<String, dynamic> json) {
    return EmailExistsResponseModel(
      exists: json['exists'],
    );
  }
}