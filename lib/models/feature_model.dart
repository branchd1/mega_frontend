import 'dart:convert';

class FeatureModel {
  final int id;
  final String name;
  final String picture;
  final String description;
  final String key;
  final Map<String, dynamic> payload;

  FeatureModel({this.id, this.name, this.picture, this.description, this.key, this.payload});

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      description: json['description'],
      key: json['key'],
      payload: jsonDecode(json['payload'])
    );
  }
}