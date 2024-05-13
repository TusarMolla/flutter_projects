// To parse this JSON data, do
//
//     final logisticsResponse = logisticsResponseFromJson(jsonString);

import 'dart:convert';

LogisticsResponse logisticsResponseFromJson(String str) => LogisticsResponse.fromJson(json.decode(str));

String logisticsResponseToJson(LogisticsResponse data) => json.encode(data.toJson());

class LogisticsResponse {
  List<LogisticInfo> data;

  LogisticsResponse({
    required this.data,
  });

  factory LogisticsResponse.fromJson(Map<String, dynamic> json) => LogisticsResponse(
    data: List<LogisticInfo>.from(json["data"].map((x) => LogisticInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LogisticInfo {
  int id;
  String name;
  int logisticId;
  String price;
  String image;

  LogisticInfo({
    required this.id,
    required this.name,
    required this.logisticId,
    required this.price,
    required this.image,
  });

  factory LogisticInfo.fromJson(Map<String, dynamic> json) => LogisticInfo(
    id: json["id"],
    name: json["name"],
    logisticId: json["logistic_id"],
    price: json["price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logistic_id": logisticId,
    "price": price,
    "image": image,
  };
}
