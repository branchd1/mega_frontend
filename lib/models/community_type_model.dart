class CommunityTypeModel{
  final int id;
  final String value;

  CommunityTypeModel({this.id, this.value});

  factory CommunityTypeModel.fromJson(Map<String, dynamic> json) {
    return CommunityTypeModel(
      id: json['id'],
      value: json['value'],
    );
  }
}