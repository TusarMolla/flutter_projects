// To parse this JSON data, do
//
//     final ticketListResponse = ticketListResponseFromJson(jsonString);

import 'dart:convert';

TicketListResponse ticketListResponseFromJson(String str) => TicketListResponse.fromJson(json.decode(str));

String ticketListResponseToJson(TicketListResponse data) => json.encode(data.toJson());

class TicketListResponse {
  bool? success;
  List<TicketData>? data;

  TicketListResponse({
    this.success,
    this.data,
  });

  factory TicketListResponse.fromJson(Map<String, dynamic> json) => TicketListResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<TicketData>.from(json["data"]!.map((x) => TicketData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TicketData {
  int? id;
  String? subject;
  String? description;
  String? status;
  String? priority;

  TicketData({
    this.id,
    this.subject,
    this.description,
    this.status,
    this.priority,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
    id: json["id"],
    subject: json["subject"],
    description: json["description"],
    status: json["status"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "description": description,
    "status": status,
    "priority": priority,
  };
}
