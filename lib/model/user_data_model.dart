class UserDataModel {
  String? email;
  String? name;
  String? phone;
  String? role;

  UserDataModel(
      {required this.email,
      required this.phone,
      required this.name,
      required this.role});

  UserDataModel.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "role": role
    };
  }
}
