// To parse this JSON data, do
//
//     final settingResponse = settingResponseFromJson(jsonString);

import 'dart:convert';

SettingResponse settingResponseFromJson(String str) => SettingResponse.fromJson(json.decode(str));

String settingResponseToJson(SettingResponse data) => json.encode(data.toJson());

class SettingResponse {
  String orderCodePrefix;

  SettingResponse({
    required this.orderCodePrefix,
  });

  factory SettingResponse.fromJson(Map<String, dynamic> json) => SettingResponse(
    orderCodePrefix: json["order_code_prefix"],
  );

  Map<String, dynamic> toJson() => {
    "order_code_prefix": orderCodePrefix,
  };
}
