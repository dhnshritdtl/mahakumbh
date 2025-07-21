class RegistrationRepo {
  bool? status;
  dynamic message;
  dynamic role;
  dynamic email;

  RegistrationRepo({required this.status, required this.message, required this.role, required this.email});

  factory RegistrationRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return RegistrationRepo(
        status: json['status'],
        email: json['email'],
        message: json['message'],
        role: json['role'] != null ?  RegistrationModel.fromJson(json['role']) : null,
      );
    } catch (error) {
      return RegistrationRepo(
        message: json['message'],
        status: json['status'],
        email: json['email'],
        role: json['role'],
      );
    }
  }
}

class RegistrationModel {
  String? name;
  String? email;
  String? remark;
  String? mobile;
  String? role;
  String? password;

  RegistrationModel(
      {this.name,
        this.email,
        this.mobile,
        this.role,
        this.remark,
        this.password
      });

  RegistrationModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    remark = json['remark'];
    mobile = json['mobile'];
    role = json['role'];
    password = json['password'];

  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['remark'] = this.remark;
    data['mobile'] = this.mobile;
    data['role'] = this.role;
    data['password'] = this.password;
    return data;
  }
}