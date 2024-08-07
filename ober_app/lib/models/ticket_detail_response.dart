// To parse this JSON data, do
//
//     final ticketDetailResponse = ticketDetailResponseFromJson(jsonString);

import 'dart:convert';

TicketDetailResponse ticketDetailResponseFromJson(String str) => TicketDetailResponse.fromJson(json.decode(str));

String ticketDetailResponseToJson(TicketDetailResponse data) => json.encode(data.toJson());

class TicketDetailResponse {
  bool? success;
  List<TicketDetail>? data;

  TicketDetailResponse({
    this.success,
    this.data,
  });

  factory TicketDetailResponse.fromJson(Map<String, dynamic> json) => TicketDetailResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<TicketDetail>.from(json["data"]!.map((x) => TicketDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TicketDetail {
  int? id;
  var userId;
  dynamic assignedTo;
  String? subject;
  String? description;
  String? status;
  String? priority;
  dynamic files;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SupportReply>? supportReply;

  TicketDetail({
    this.id,
    this.userId,
    this.assignedTo,
    this.subject,
    this.description,
    this.status,
    this.priority,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.supportReply,
  });

  factory TicketDetail.fromJson(Map<String, dynamic> json) => TicketDetail(
    id: json["id"],
    userId: json["user_id"],
    assignedTo: json["assignedTo"],
    subject: json["subject"],
    description: json["description"],
    status: json["status"],
    priority: json["priority"],
    files: json["files"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    supportReply: json["support_reply"] == null ? [] : List<SupportReply>.from(json["support_reply"]!.map((x) => SupportReply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "assignedTo": assignedTo,
    "subject": subject,
    "description": description,
    "status": status,
    "priority": priority,
    "files": files,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "support_reply": supportReply == null ? [] : List<dynamic>.from(supportReply!.map((x) => x.toJson())),
  };
}

class SupportReply {
  int? id;
  int? ticketId;
  int? userId;
  String? message;
  dynamic files;
  DateTime? createdAt;
  DateTime? updatedAt;

  SupportReply({
    this.id,
    this.ticketId,
    this.userId,
    this.message,
    this.files,
    this.createdAt,
    this.updatedAt,
  });

  factory SupportReply.fromJson(Map<String, dynamic> json) => SupportReply(
    id: json["id"],
    ticketId: json["ticket_id"],
    userId: json["user_id"],
    message: json["message"],
    files: json["files"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_id": ticketId,
    "user_id": userId,
    "message": message,
    "files": files,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
