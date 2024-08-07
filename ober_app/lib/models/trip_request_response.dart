// To parse this JSON data, do
//
//     final tripRequestResponse = tripRequestResponseFromJson(jsonString);

import 'dart:convert';

TripRequestResponse tripRequestResponseFromJson(String str) => TripRequestResponse.fromJson(json.decode(str));

String tripRequestResponseToJson(TripRequestResponse data) => json.encode(data.toJson());

class TripRequestResponse {
  bool? success;
  String? message;
  List<VehicleCategory>? categories;
  int? tripId;

  TripRequestResponse({
    this.success,
    this.message,
    this.categories,
    this.tripId,
  });

  factory TripRequestResponse.fromJson(Map<String, dynamic> json) => TripRequestResponse(
    success: json["success"],
    message: json["message"],
    categories: json["categories"] == null ? [] : List<VehicleCategory>.from(json["categories"]!.map((x) => VehicleCategory.fromJson(x))),
    tripId: json["trip_id"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "trip_id": tripId,
  };
}

class VehicleCategory {
  int? id;
  String? name;
  String? ratePerKm;
  var rate;
  var additional_notes;
  DateTime? createdAt;
  dynamic updatedAt;

  VehicleCategory({
    this.id,
    this.name,
    this.ratePerKm,
    this.rate,
    this.additional_notes,
    this.createdAt,
    this.updatedAt,
  });

  factory VehicleCategory.fromJson(Map<String, dynamic> json) => VehicleCategory(
    id: json["id"],
    name: json["name"],
    rate: json["rate"],
    additional_notes: json["additional_notes"],
    ratePerKm: json["rate_per_km"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "rate_per_km": ratePerKm,
    "rate": rate,
    "additional_notes": additional_notes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
  };
}
