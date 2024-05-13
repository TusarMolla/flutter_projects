// To parse this JSON data, do
//
//     final commonResponse = commonResponseFromJson(jsonString);

import 'dart:convert';

CommonResponse commonResponseFromJson(String str) => CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  bool result;
  var message;

  CommonResponse({
    required this.result,
    required this.message,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}
