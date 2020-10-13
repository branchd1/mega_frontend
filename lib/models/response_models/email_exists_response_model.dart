
/// Response from REST API from check if email exists
class EmailExistsResponseModel{
  /// Represents if the email exists or not
  /// True if it exists, false otherwise
  final bool _exists;

  // Getter
  bool get exists => _exists;

  EmailExistsResponseModel(this._exists);

  /// Create object from JSON data
  factory EmailExistsResponseModel.fromJson(Map<String, dynamic> json) {
    return EmailExistsResponseModel(
      json['exists'],
    );
  }
}