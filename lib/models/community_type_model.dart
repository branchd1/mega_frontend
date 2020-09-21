
/// Represents community type
class CommunityTypeModel{
  /// Community type id
  final int _id;

  /// Community type human readable value
  final String _value;

  // The Getters
  int get id => _id;
  String get value => _value;

  CommunityTypeModel(this._id, this._value);

  /// create object from JSON data
  factory CommunityTypeModel.fromJson(Map<String, dynamic> json) {
    return CommunityTypeModel(
      json['id'],
      json['value'],
    );
  }
}