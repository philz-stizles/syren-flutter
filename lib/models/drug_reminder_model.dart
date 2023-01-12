class DrugReminderModel {
  int? id;
  String? name;

  DrugReminderModel({this.id, this.name});

  DrugReminderModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
