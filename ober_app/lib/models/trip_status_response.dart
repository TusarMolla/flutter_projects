// To parse this JSON data, do
//
//     final tripStatusResponse = tripStatusResponseFromJson(jsonString);

import 'dart:convert';

TripStatusResponse tripStatusResponseFromJson(String str) => TripStatusResponse.fromJson(json.decode(str));

String tripStatusResponseToJson(TripStatusResponse data) => json.encode(data.toJson());

class TripStatusResponse {
  bool? success;
  Data? data;

  TripStatusResponse({
    this.success,
    this.data,
  });

  factory TripStatusResponse.fromJson(Map<String, dynamic> json) => TripStatusResponse(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;

  Data({
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
