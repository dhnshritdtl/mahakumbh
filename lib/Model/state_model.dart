class StateModelRepo {
  bool status;
  dynamic data;

  StateModelRepo({required this.status, required this.data});

  factory StateModelRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return StateModelRepo(
        status: json['status'],
        data: json['data'] != null ? new StateModel.fromJson(json['data']) : null,
      );
    } catch (error) {
      return StateModelRepo(
        status: json['status'],
        data: null,
      );
    }
  }
}

class StateModel {
  int? stateId;
  String? stateName;

  StateModel({required this.stateId, required this.stateName});

  StateModel.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    return data;
  }
}