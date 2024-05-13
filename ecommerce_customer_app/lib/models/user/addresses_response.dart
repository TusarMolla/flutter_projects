// To parse this JSON data, do
//
//     final addressesResponse = addressesResponseFromJson(jsonString);

import 'dart:convert';

AddressesResponse addressesResponseFromJson(String str) => AddressesResponse.fromJson(json.decode(str));

String addressesResponseToJson(AddressesResponse data) => json.encode(data.toJson());

class AddressesResponse {
  List<AddressInfo> data;

  AddressesResponse({
    required this.data,
  });

  factory AddressesResponse.fromJson(Map<String, dynamic> json) => AddressesResponse(
    data: List<AddressInfo>.from(json["data"].map((x) => AddressInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AddressInfo {
  var id;
  var userId;
  var countryId;
  String countryName;
  var stateId;
  String stateName;
  var cityId;
  String cityName;
  String address;
  var isDefault;

  AddressInfo({
    required this.id,
    required this.userId,
    required this.countryId,
    required this.countryName,
    required this.stateId,
    required this.stateName,
    required this.cityId,
    required this.cityName,
    required this.address,
    required this.isDefault,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
    id: json["id"],
    userId: json["user_id"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    address: json["address"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "country_id": countryId,
    "country_name": countryName,
    "state_id": stateId,
    "state_name": stateName,
    "city_id": cityId,
    "city_name": cityName,
    "address": address,
    "is_default": isDefault,
  };
}
