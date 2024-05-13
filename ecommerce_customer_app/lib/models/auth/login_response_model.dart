// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:grostore/models/common/user_info.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
LoginResponse loginResponseDefaultValue() => LoginResponse(result: false, message: "Faild", accessToken: "", tokenType: "",user: UserInfo.init());

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool result;
  String message;
  String accessToken;
  String tokenType;
  UserInfo user;


  LoginResponse({
    required this.result,
    required this.message,
    required this.accessToken,
    required this.tokenType,
    required this.user

  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    result: json["result"],
    message: json["message"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    user: UserInfo.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "access_token": accessToken,
    "token_type": tokenType,
    "user": user.toJson(),
  };
}
