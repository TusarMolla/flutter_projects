// To parse this JSON data, do
//
//     final helpCenterResponse = helpCenterResponseFromJson(jsonString);

import 'dart:convert';

HelpCenterResponse helpCenterResponseFromJson(String str) => HelpCenterResponse.fromJson(json.decode(str));

String helpCenterResponseToJson(HelpCenterResponse data) => json.encode(data.toJson());

class HelpCenterResponse {
  String location;
  String contactNumber;
  String email;

  HelpCenterResponse({
    required this.location,
    required this.contactNumber,
    required this.email,
  });

  factory HelpCenterResponse.fromJson(Map<String, dynamic> json) => HelpCenterResponse(
    location: json["location"],
    contactNumber: json["contact_number"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "location": location,
    "contact_number": contactNumber,
    "email": email,
  };
}
