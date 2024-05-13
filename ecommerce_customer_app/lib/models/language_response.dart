// To parse this JSON data, do
//
//     final languageResponse = languageResponseFromJson(jsonString);

import 'dart:convert';

LanguageResponse languageResponseFromJson(String str) => LanguageResponse.fromJson(json.decode(str));

String languageResponseToJson(LanguageResponse data) => json.encode(data.toJson());

class LanguageResponse {
  List<LanguageInfo> data;

  LanguageResponse({
    required this.data,
  });

  factory LanguageResponse.fromJson(Map<String, dynamic> json) => LanguageResponse(
    data: List<LanguageInfo>.from(json["data"].map((x) => LanguageInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LanguageInfo {
  int id;
  String name;
  String flag;
  String code;
  var isRtl;
  var isActive;

  LanguageInfo({
    required this.id,
    required this.name,
    required this.flag,
    required this.code,
    required this.isRtl,
    required this.isActive,
  });

  factory LanguageInfo.fromJson(Map<String, dynamic> json) => LanguageInfo(
    id: json["id"],
    name: json["name"],
    flag: json["flag"],
    code: json["code"],
    isRtl: json["is_rtl"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "flag": flag,
    "code": code,
    "is_rtl": isRtl,
    "is_active": isActive,
  };
}
