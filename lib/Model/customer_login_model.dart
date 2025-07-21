class CustomerLoginRepo {
  dynamic status;
  dynamic message;
  CustomerLoginModel? data;
  dynamic access;
  dynamic refresh;
  dynamic role;

  CustomerLoginRepo(
      {this.status, this.data, this.access, this.message, this.refresh, this.role});

  factory CustomerLoginRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CustomerLoginRepo(
          status: json['status'],
          data: json['data'] != null
              ? CustomerLoginModel.fromJson(json['data'])
              : null,
          access: json['access'],
          message: json['message'],
          refresh: json['refresh'],
          role: json['role']
      );
    } catch (error) {
      return CustomerLoginRepo(
        message: json['message'],
        data: null,
      );
    }
  }
}
class CustomerLoginModel {
  int? adminId;
  String? name;
  String? email;
  String? role;
  String? status;

  CustomerLoginModel({this.adminId, this.name, this.email, this.role, this.status});

  CustomerLoginModel.fromJson(Map<String, dynamic> json) {
    adminId = json['admin_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_id'] = this.adminId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['status'] = this.status;
    return data;
  }
}