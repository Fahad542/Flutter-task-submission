class UserModel {
  final int id;
  final String name;
  final String empId;
  final String email;
  final String company;

  final String platform;

  UserModel({
    required this.id,
    required this.name,
    required this.empId,
    required this.email,
    required this.company,
    required this.platform,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      empId: json['Empid'],
      email: json['email'],
      company: json['Company'],
      platform: json['Platform'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'Empid': empId,
      'email': email,
      'Company': company,
      'Platform': platform,
    };
  }
}
