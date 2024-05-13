// To parse this JSON data, do
//
//     final registrationResponse = registrationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:grostore/models/common/user_info.dart';

RegistrationResponse registrationResponseFromJson(String str) => RegistrationResponse.fromJson(json.decode(str));
RegistrationResponse registrationResponseDefault() => RegistrationResponse.fromJson(json.decode(
  '''{
    "result": false,
    "message": "",
    "access_token": "",
    "token_type": ""
}'''
));

String registrationResponseToJson(RegistrationResponse data) => json.encode(data.toJson());

class RegistrationResponse {
  bool result;
  var message;
  String accessToken;
  String tokenType;
  UserInfo user;

  RegistrationResponse({
    required this.result,
    required this.message,
    required this.accessToken,
    required this.tokenType,
    required this.user

  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => RegistrationResponse(
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
