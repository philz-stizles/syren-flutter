class VitalReminderModel {
  int? id;
  String? title;
  String? note;
  String? date;

  VitalReminderModel({this.id, this.title, this.note, this.date});

  VitalReminderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['note'] = note;
    data['date'] = date;
    return data;
  }
}
