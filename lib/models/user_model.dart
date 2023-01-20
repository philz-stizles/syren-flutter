class UserModel {
  String? id;
  String? name;
  String? email;
  String? gender;
  String? religion;
  String? phone;
  String? dob;
  bool? hasAllergies;
  String? allergies;
  String? medications;
  bool? hasMedicalConditions;
  String? medicalConditions;
  String? genoType;
  String? bloodGroup;
  late String role;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.gender,
      this.religion,
      this.phone,
      this.dob,
      this.hasAllergies,
      this.allergies,
      this.medications,
      this.hasMedicalConditions,
      this.medicalConditions,
      this.genoType,
      this.bloodGroup,
      this.role = 'user'});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    religion = json['religion'];
    phone = json['phone'];
    dob = json['dob'];
    hasAllergies = json['hasAllergies'];
    allergies = json['allergies'];
    hasMedicalConditions = json['hasMedicalConditions'];
    medicalConditions = json['medicalConditions'];
    genoType = json['genoType'];
    bloodGroup = json['bloodGroup'];
    role = json['role'];
  }

  UserModel.fromDocumentSnapshot(String docId, Map<String, dynamic>? docData) {
    id = docId;
    name = docData?['name'];
    email = docData?['email'];
    gender = docData?['gender'];
    religion = docData?['religion'];
    phone = docData?['phone'];
    dob = docData?['dob'];
    hasAllergies = docData?['hasAllergies'];
    allergies = docData?['allergies'];
    hasMedicalConditions = docData?['hasMedicalConditions'];
    medications = docData?['medications'];
    medicalConditions = docData?['medicalConditions'];
    genoType = docData?['genoType'];
    bloodGroup = docData?['bloodGroup'];
    role = docData?['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['religion'] = religion;
    data['phone'] = phone;
    data['dob'] = dob;
    data['hasAllergies'] = hasAllergies;
    data['allergies'] = allergies;
    data['hasMedicalConditions'] = hasMedicalConditions;
    data['medications'] = medications;
    data['medicalConditions'] = medicalConditions;
    data['genoType'] = genoType;
    data['bloodGroup'] = bloodGroup;
    data['role'] = role;

    return data;
  }

  @override
  String toString() => '''UserModel{
    id: $id, 
    name: $name, 
    email: $email, 
    gender: $gender, 
    religion: $religion
  }''';
}
