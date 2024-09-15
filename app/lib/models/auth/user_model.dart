class UserModel {
  int id;
  String fullname;
  String phoneNumber;
  String address;

  UserModel({
    required this.id,
    required this.fullname,
    required this.phoneNumber,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      fullname: json["fullname"] ?? 'Hoàng',
      phoneNumber: json["phone_number"] ?? 'No phone number',
      address: json["address"] ?? 'No address',
      // Handle other fields similarly
    );
  }


  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone_number": phoneNumber,
        "address": address,
      };
}
