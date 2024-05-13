// To parse this JSON data, do
//
//     final userInfoResponse = userInfoResponseFromJson(jsonString);

import 'dart:convert';

import 'common/user_info.dart';

UserInfoResponse userInfoResponseFromJson(String str) => UserInfoResponse.fromJson(json.decode(str));
UserInfoResponse userInfoResponseDefault() => UserInfoResponse.fromJson(json.decode('''
{
    "data": {
        "name": "",
        "email": "",
        "phone": "",
        "balance": 0,
        "avatar": ""
    },
    "result": false,
    "message": "failed"
}
'''));

String userInfoResponseToJson(UserInfoResponse data) => json.encode(data.toJson());

class UserInfoResponse {
  UserInfo data;
  bool result;
  String message;

  UserInfoResponse({
    required this.data,
    required this.result,
    required this.message,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) => UserInfoResponse(
    data: UserInfo.fromJson(json["data"]),
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "result": result,
    "message": message,
  };
}


