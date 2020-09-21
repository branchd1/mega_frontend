import 'dart:convert';

/// Represents a feature
class FeatureModel {
  /// Feature id
  final int _id;

  /// Feature name
  final String _name;

  /// Feature picture
  final String _pictureUrl;

  /// Feature description
  final String _description;

  /// Feature key
  final String _key;

  /// Feature payload
  /// The code which determines what widgets show on the feature MiniApp
  final Map<String, dynamic> _payload;

  // Getters
  int get id => _id;
  String get name => _name;
  String get pictureUrl => _pictureUrl;
  String get description => _description;
  Map<String, dynamic> get payload => _payload;
  String get key => _key;

  FeatureModel(this._id, this._name, this._pictureUrl,
      this._description, this._key, this._payload);

  /// create object from JSON data
  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      json['id'],
      json['name'],
      json['picture'],
      json['description'],
      json['key'],
      jsonDecode(json['payload'])
    );
  }
}