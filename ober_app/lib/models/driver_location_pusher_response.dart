// To parse this JSON data, do
//
//     final driverLocationPusherResponse = driverLocationPusherResponseFromJson(jsonString);

import 'dart:convert';

DriverLocationPusherResponse driverLocationPusherResponseFromJson(String str) => DriverLocationPusherResponse.fromJson(json.decode(str));

String driverLocationPusherResponseToJson(DriverLocationPusherResponse data) => json.encode(data.toJson());

class DriverLocationPusherResponse {
  int? id;
  String? latitude;
  String? longitude;

  DriverLocationPusherResponse({
    this.id,
    this.latitude,
    this.longitude,
  });

  factory DriverLocationPusherResponse.fromJson(Map<String, dynamic> json) => DriverLocationPusherResponse(
    id: json["user_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": id,
    "latitude": latitude,
    "longitude": longitude,
  };
}
