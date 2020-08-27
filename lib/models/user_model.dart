class UserModel {
  final int id;
  final int profileId;
  final String email;
  final String firstName;
  final String lastName;
  final String pictureUrl;
  final String phoneNumber;

  UserModel({this.id, this.email, this.firstName, this.lastName, this.pictureUrl, this.phoneNumber, this.profileId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      pictureUrl: json['picture'],
      phoneNumber: json['phone_number'],
      profileId: json['profileId']
    );
  }
}