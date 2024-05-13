// To parse this JSON data, do
//
//     final cityResponse = cityResponseFromJson(jsonString);

import 'dart:convert';

CityResponse cityResponseFromJson(String str) => CityResponse.fromJson(json.decode(str));

String cityResponseToJson(CityResponse data) => json.encode(data.toJson());

class CityResponse {
  List<CityInfo> data;

  CityResponse({
    required this.data,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
    data: List<CityInfo>.from(json["data"].map((x) => CityInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CityInfo {
  int stateId;
  int id;
  String name;
  bool isActive;

  CityInfo({
    required this.stateId,
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory CityInfo.fromJson(Map<String, dynamic> json) => CityInfo(
    stateId: json["state_id"],
    id: json["id"],
    name: json["name"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "id": id,
    "name": name,
    "is_active": isActive,
  };
}
