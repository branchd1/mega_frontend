class CreateCommunityResponseModel {
  final dynamic name;
  final dynamic type;
  final String pictureUrl;
  final String description;
  final bool isPublic;
  final String key;

  CreateCommunityResponseModel({this.key, this.name, this.type, this.pictureUrl, this.description, this.isPublic});

  factory CreateCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateCommunityResponseModel(
      name: json['name'],
      type: json['type'],
      pictureUrl: json['pictureUrl'],
      description: json['description'],
      isPublic: json['isPublic'],
      key: json['key'],
    );
  }

  String errorToString() {
    if (name != null && name is List<dynamic>){
      return name[0];
    } else if (type != null && type is List<dynamic>){
      return type[0];
    } else {
      return null;
    }
  }

}