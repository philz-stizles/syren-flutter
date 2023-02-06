class PlaceSearchModel {
  int? id;
  late String name;

  PlaceSearchModel({this.id, required this.name});

  PlaceSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
