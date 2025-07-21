class DistrictModelRepo {
  bool status;
  dynamic data;

  DistrictModelRepo({required this.status, this.data});

  factory DistrictModelRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return DistrictModelRepo(
        status: json['status'],
        data: json['data'] != null ? new DistrictModel.fromJson(json['data']) : null,
      );
    } catch (error) {
      return DistrictModelRepo(
        status: json['status'],
        data: null,
      );
    }
  }
}

class DistrictModel {
  int? districtId;
  String? districtName;
  int? stateId;

  DistrictModel({required this.districtId, required this.districtName, required this.stateId});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    districtId = json['district_id'];
    districtName = json['district_name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['state_id'] = this.stateId;
    return data;
  }
}