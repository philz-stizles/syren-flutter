class DrugReminderModel {
  int? id;
  String? name;

  DrugReminderModel({this.id, this.name});

  DrugReminderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
