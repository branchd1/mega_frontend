
/// Response from REST API from joining a community
class JoinCommunityResponseModel{
  /// The community key
  final dynamic _key;

  // Getter
  dynamic get key => _key;

  JoinCommunityResponseModel(this._key);

  /// Create object from JSON data
  factory JoinCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    return JoinCommunityResponseModel(json['key']);
  }

  /// Create object from error JSON data
  String errorToString() {
    if (_key != null && _key is String){
      return _key;
    } else {
      return null;
    }
  }
}