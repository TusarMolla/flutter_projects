// To parse this JSON data, do
//
//     final editAddressResponse = editAddressResponseFromJson(jsonString);

import 'dart:convert';

EditAddressResponse editAddressResponseFromJson(String str) =>
    EditAddressResponse.fromJson(json.decode(str));

String editAddressResponseToJson(EditAddressResponse data) =>
    json.encode(data.toJson());

class EditAddressResponse {
  Data data;
  bool result;
  int status;

  EditAddressResponse({
    required this.data,
    required this.result,
    required this.status,
  });

  factory EditAddressResponse.fromJson(Map<String, dynamic> json) =>
      EditAddressResponse(
        data: Data.fromJson(json["data"]),
        result: json["result"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "result": result,
        "status": status,
      };
}

class Data {
  int id;
  int userId;
  int countryId;
  String countryName;
  int stateId;
  String stateName;
  int cityId;
  String cityName;
  String address;
  int isDefault;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
