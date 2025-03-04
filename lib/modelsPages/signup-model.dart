class SignupModel {
  String? email;
  String? name, phoneNumber;
  String? id, location;
  String? appId;
  SignupModel(
      {required this.name,
      required this.phoneNumber,
      required this.id,
      required this.location,
      required this.email,
      required this.appId});

  Map<String, dynamic> dataToMap() {
    return {
      'user_name': name,
      'user_email': email,
      'user_id': id,
      'user_phone_number': phoneNumber,
      'user_location': location,
      'appId': appId
    };
  }

  SignupModel.mapToData(Map<String, dynamic> map) {
    name = map["user_name"];
    email = map["user_email"];
    id = map["user_id"];
    phoneNumber = map['user_phone_number'];
    location = map["user_location"];
    appId = map['appId'];
  }
}
