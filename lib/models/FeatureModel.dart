class FeatureModel {
  final int id;
  final String name;
  final String picture;
  final String communityType;
  final String description;

  FeatureModel({this.id, this.name, this.picture, this.communityType, this.description});

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
        id: json['id'],
        name: json['name'],
        picture: json['picture'],
        communityType: json['community_type'],
        description: json['description']
    );
  }
}