// To parse this JSON data, do
//
//     final locationsResponse = locationsResponseFromJson(jsonString);

import 'dart:convert';

LocationsResponse locationsResponseFromJson(String str) => LocationsResponse.fromJson(json.decode(str));

String locationsResponseToJson(LocationsResponse data) => json.encode(data.toJson());

class LocationsResponse {
  List<LocationInfo> data;

  LocationsResponse({
    required this.data,
  });

  factory LocationsResponse.fromJson(Map<String, dynamic> json) => LocationsResponse(
    data: List<LocationInfo>.from(json["data"].map((x) => LocationInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LocationInfo {
  int id;
  String name;
  String image;
  String address;
  dynamic lat;
  dynamic lng;
  bool isDefault;

  LocationInfo({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    this.lat,
    this.lng,
    required this.isDefault,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    address: json["address"],
    lat: json["lat"],
    lng: json["lng"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "address": address,
    "lat": lat,
    "lng": lng,
    "is_default": isDefault,
  };
}
