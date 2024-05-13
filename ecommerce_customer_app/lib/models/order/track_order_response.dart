// To parse this JSON TrackInfo, do
//
//     final trackOrderResponse = trackOrderResponseFromJson(jsonString);

import 'dart:convert';

TrackOrderResponse trackOrderResponseFromJson(String str) => TrackOrderResponse.fromJson(json.decode(str));

String trackOrderResponseToJson(TrackOrderResponse data) => json.encode(data.toJson());

class TrackOrderResponse {
  TrackInfo? data;

  TrackOrderResponse({
     this.data,
  });

  factory TrackOrderResponse.fromJson(Map<String, dynamic> json) => TrackOrderResponse(
    data:json["data"]==null?null: TrackInfo.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class TrackInfo {
  int id;
  List<OrderUpdate> orderUpdates;
  String createdDate;

  TrackInfo({
    required this.id,
    required this.orderUpdates,
    required this.createdDate,
  });

  factory TrackInfo.fromJson(Map<String, dynamic> json) => TrackInfo(
    id: json["id"],
    orderUpdates: List<OrderUpdate>.from(json["order_updates"].map((x) => OrderUpdate.fromJson(x))),
    createdDate: json["created_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_updates": List<dynamic>.from(orderUpdates.map((x) => x.toJson())),
    "created_date": createdDate,
  };
}

class OrderUpdate {
  String date;
  String note;

  OrderUpdate({
    required this.date,
    required this.note,
  });

  factory OrderUpdate.fromJson(Map<String, dynamic> json) => OrderUpdate(
    date: json["date"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "note": note,
  };
}
