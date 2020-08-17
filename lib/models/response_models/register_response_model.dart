class RegisterResponseModel{
  final dynamic username;
  final dynamic email;
  final dynamic password;
  final dynamic rePassword;

  RegisterResponseModel({this.username, this.email, this.password, this.rePassword});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      rePassword: json['re_password'],
    );
  }

  String errorToString() {
    if (username != null && username is List<dynamic>){
      return username[0];
    } else if (email != null && email is List<dynamic>){
      return email[0];
    } else if (password != null && password is List<dynamic>){
      return password[0];
    } else {
      return null;
    }
  }
}