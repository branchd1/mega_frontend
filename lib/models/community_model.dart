/// Represents a community
class CommunityModel {
  /// Community id
  final int _id;

  /// Community name
  final String _name;

  /// Community type
  final String _type;

  /// Community picture url
  final String _pictureUrl;

  /// Community description
  final String _description;

  /// Community key
  final String _key;

  /// Check user is an admin of the community or not
  final bool _isAdmin;

  // Getters
  int get id => _id;
  String get name => _name;
  String get type => _type;
  String get pictureUrl => _pictureUrl;
  String get description => _description;
  bool get isAdmin => _isAdmin;
  String get key => _key;

  CommunityModel(this._id, this._name, this._type, this._pictureUrl,
      this._description, this._isAdmin, this._key);

  /// create object from JSON data
  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      json['id'],
      json['name'],
      json['type_value'],
      json['picture'],
      json['description'],
      json['is_admin'],
      json['key'],
    );
  }
}