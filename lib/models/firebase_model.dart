abstract class FirebaseModel<T> {
  String? id;

  FirebaseModel(this.id);

  // T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
