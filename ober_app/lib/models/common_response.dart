// To parse this JSON data, do
//
//     final commonResponse = commonResponseFromJson(jsonString);

import 'dart:convert';

CommonResponse commonResponseFromJson<T>(String str) => CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

typedef SEOTypedef =  Function(Map<String, dynamic> data);

class CommonResponse {
  bool? status;
  var success;
  var message;
  var messages;
  var details;
  var error;
  var errors;


  CommonResponse({
    this.status,
    this.message,
    this.messages,
    this.success,
    this.details,
    this.error,
    this.errors
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      CommonResponse(
        status: json["status"],
        message: json["message"],
        messages: json["messages"],
        success: json["success"],
        details: json["details"],
        error: json["error"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "message": message,
        "details": details,
        "data": error,
        "errors": errors,
      };
}

