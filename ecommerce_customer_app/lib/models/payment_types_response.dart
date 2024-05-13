// To parse this JSON data, do
//
//     final paymentTypesResponse = paymentTypesResponseFromJson(jsonString);

import 'dart:convert';

List<PaymentTypesResponse> paymentTypesResponseFromJson(String str) => List<PaymentTypesResponse>.from(json.decode(str).map((x) => PaymentTypesResponse.fromJson(x)));

String paymentTypesResponseToJson(List<PaymentTypesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentTypesResponse {
  String key;
  String name;
  String image;

  PaymentTypesResponse({
    required this.key,
    required this.name,
    required this.image,
  });

  factory PaymentTypesResponse.fromJson(Map<String, dynamic> json) => PaymentTypesResponse(
    key: json["key"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "image": image,
  };
}
