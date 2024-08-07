// To parse this JSON data, do
//
//     final profileInfoResponse = profileInfoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ober_app/models/error_response.dart';

ProfileInfoResponse profileInfoResponseFromJson(String str) => ProfileInfoResponse.fromJson(json.decode(str));

String profileInfoResponseToJson(ProfileInfoResponse data) => json.encode(data.toJson());

class ProfileInfoResponse extends ErrorResponse{
  bool? success;
  ProfileData? data;

  ProfileInfoResponse({
    this.success,
    this.data,
  });

  ProfileInfoResponse setErrors(ErrorResponse response) {
    error = response.error;
    message = response.message;
    return this;
  }

  factory ProfileInfoResponse.fromJson(Map<String, dynamic> json) => ProfileInfoResponse(
    success: json["success"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class ProfileData {
  int? id;
  var userId;
  String? firstName;
  String? lastName;
  DateTime? dob;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? socialNumber;
  String? cardHolderName;
  String? cardNumber;
  String? expDate;
  String? cvc;
  bool? isInit;


  ProfileData({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.dob,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isInit,
    this.socialNumber,
    this.cardHolderName,
    this.cardNumber,
    this.expDate,
    this.cvc
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    phoneNumber: json["phone_number"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    country: json["country"],
    socialNumber: json["social_number"],
    cardHolderName: json["card_holder_name"],
    cardNumber: json["card_number"],
    expDate: json["exp_date"],
    cvc: json["cvc"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isInit: true
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "phone_number": phoneNumber,
    "address": address,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "country": country,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_init":isInit
  };
}
