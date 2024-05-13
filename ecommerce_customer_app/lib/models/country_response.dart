// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

CountryResponse countryResponseFromJson(String str) => CountryResponse.fromJson(json.decode(str));

String countryResponseToJson(CountryResponse data) => json.encode(data.toJson());

class CountryResponse {
  List<CountryInfo> data;

  CountryResponse({
    required this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
    data: List<CountryInfo>.from(json["data"].map((x) => CountryInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CountryInfo {
  int id;
  String code;
  String name;
  bool isActive;

  CountryInfo({
    required this.id,
    required this.code,
    required this.name,
    required this.isActive,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "is_active": isActive,
  };
}
