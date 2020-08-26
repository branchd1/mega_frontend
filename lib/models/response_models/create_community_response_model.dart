class CreateCommunityResponseModel {
  final dynamic name;
  final dynamic type;
  final dynamic picture;
  final String description;
  final bool isPublic;
  final String key;

  CreateCommunityResponseModel({this.key, this.name, this.type, this.picture, this.description, this.isPublic});

  factory CreateCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateCommunityResponseModel(
      name: json['name'],
      type: json['type'],
      picture: json['picture'],
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
    } else if (picture != null && picture is List<dynamic>){
      return picture[0];
    } else {
      return null;
    }
  }

}