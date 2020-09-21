/// Represents a User
class UserModel {
  /// The user's identifier
  final int _id;

  /// The user's profile identifier
  final int _profileId;

  /// The user's email
  final String _email;

  /// The user's first name
  final String _firstName;

  /// The user's last name
  final String _lastName;

  /// The user's picture URL
  final String _pictureUrl;

  /// The user's phone number
  final String _phoneNumber;

  // Getters for class attributes
  int get id => _id;
  int get profileId => _profileId;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get pictureUrl => _pictureUrl;
  String get lastName => _lastName;
  String get firstName => _firstName;

  UserModel(this._id, this._email, this._firstName, this._lastName, this._pictureUrl, this._phoneNumber, this._profileId);

  /// create object from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['id'],
      json['email'],
      json['first_name'],
      json['last_name'],
      json['picture'],
      json['phone_number'],
      json['profileId']
    );
  }
}