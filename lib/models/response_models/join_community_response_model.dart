class JoinCommunityResponseModel{
  final dynamic key;

  JoinCommunityResponseModel({this.key});

  factory JoinCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    return JoinCommunityResponseModel(
      key: json['key'],
    );
  }

  String errorToString() {
    if (key != null && key is String){
      return key;
    } else {
      return null;
    }
  }
}