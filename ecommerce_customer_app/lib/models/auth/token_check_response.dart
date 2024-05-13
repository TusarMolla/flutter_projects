// To parse this JSON data, do
//
//     final tokenCheckResponse = tokenCheckResponseFromJson(jsonString);

import 'dart:convert';

import 'package:grostore/models/common/user_info.dart';

TokenCheckResponse tokenCheckResponseFromJson(String str) => TokenCheckResponse.fromJson(json.decode(str));

String tokenCheckResponseToJson(TokenCheckResponse data) => json.encode(data.toJson());

class TokenCheckResponse {
  bool result;
  UserInfo user;

  TokenCheckResponse({
    required this.result,
    required this.user,
  });

  factory TokenCheckResponse.fromJson(Map<String, dynamic> json) => TokenCheckResponse(
    result: json["result"],
    user: UserInfo.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "user": user.toJson(),
  };
}



