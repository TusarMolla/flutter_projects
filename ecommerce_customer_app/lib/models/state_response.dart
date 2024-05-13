// To parse this JSON data, do
//
//     final stateResponse = stateResponseFromJson(jsonString);

import 'dart:convert';

StateResponse stateResponseFromJson(String str) => StateResponse.fromJson(json.decode(str));

String stateResponseToJson(StateResponse data) => json.encode(data.toJson());

class StateResponse {
  List<StateInfo> data;

  StateResponse({
    required this.data,
  });

  factory StateResponse.fromJson(Map<String, dynamic> json) => StateResponse(
    data: List<StateInfo>.from(json["data"].map((x) => StateInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StateInfo {
  int countryId;
  int id;
  String name;
  bool isActive;

  StateInfo({
    required this.countryId,
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory StateInfo.fromJson(Map<String, dynamic> json) => StateInfo(
    countryId: json["country_id"],
    id: json["id"],
    name: json["name"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "id": id,
    "name": name,
    "is_active": isActive,
  };
}
