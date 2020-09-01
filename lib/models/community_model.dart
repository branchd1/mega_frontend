class CommunityModel {
  final int id;
  final String name;
  final String type;
  final String picture;
  final String description;
  final bool isAdmin;

  CommunityModel({this.id, this.name, this.type, this.picture, this.description, this.isAdmin});

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      name: json['name'],
      type: json['type_value'],
      picture: json['picture'],
      description: json['description'],
      isAdmin: json['is_admin']
    );
  }
}