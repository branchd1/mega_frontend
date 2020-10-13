
/// Response from REST API from create community request
class CreateCommunityResponseModel {
  /// The community name
  final dynamic _name;

  /// The community type
  final dynamic _type;

  /// The community picture
  final dynamic _picture;

  /// The community description
  final String _description;

  /// Whether the community is public or not
  final bool _isPublic;
  final String _key;

  // Getters
  dynamic get name => _name;
  dynamic get type => _type;
  dynamic get picture => _picture;
  String get description => _description;
  bool get isPublic => _isPublic;
  String get key => _key;

  CreateCommunityResponseModel(this._key, this._name, this._type,
      this._picture, this._description, this._isPublic);

  /// Create object from JSON data
  factory CreateCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateCommunityResponseModel(
      json['key'],
      json['name'],
      json['type'],
      json['picture'],
      json['description'],
      json['isPublic'],
    );
  }

  /// Create object from error JSON data
  /// If request errors, create object from error response
  String errorToString() {
    if (_name != null && _name is List<dynamic>){
      return _name[0];
    } else if (_type != null && _type is List<dynamic>){
      return _type[0];
    } else if (_picture != null && _picture is List<dynamic>){
      return _picture[0];
    } else {
      return null;
    }
  }
}