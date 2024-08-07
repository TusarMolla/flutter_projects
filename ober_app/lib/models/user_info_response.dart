// To parse this JSON data, do
//
//     final userInfoResponse = userInfoResponseFromJson(jsonString);

import 'dart:convert';

UserInfoResponse userInfoResponseFromJson(String str) => UserInfoResponse.fromJson(json.decode(str));

String userInfoResponseToJson(UserInfoResponse data) => json.encode(data.toJson());

class UserInfoResponse {
  User? user;

  UserInfoResponse({
    this.user,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) => UserInfoResponse(
    user: json["user_details"] == null ? null : User.fromJson(json["user_details"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? username;
  String? email;
  dynamic emailVerifiedAt;
  String? balance;
  dynamic refBy;
  String? role;
  DateTime? registrationDate;
  dynamic lastLoginDate;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.balance,
    this.refBy,
    this.role,
    this.registrationDate,
    this.lastLoginDate,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    balance: json["balance"],
    refBy: json["ref_by"],
    role: json["role"],
    registrationDate: json["registration_date"] == null ? null : DateTime.parse(json["registration_date"]),
    lastLoginDate: json["last_login_date"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "balance": balance,
    "ref_by": refBy,
    "role": role,
    "registration_date": registrationDate?.toIso8601String(),
    "last_login_date": lastLoginDate,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
