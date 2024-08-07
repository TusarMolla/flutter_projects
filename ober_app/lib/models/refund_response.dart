// To parse this JSON data, do
//
//     final refundResponse = refundResponseFromJson(jsonString);

import 'dart:convert';

RefundResponse refundResponseFromJson(String str) => RefundResponse.fromJson(json.decode(str));

String refundResponseToJson(RefundResponse data) => json.encode(data.toJson());

class RefundResponse {
  bool? success;
  Data? data;

  RefundResponse({
    this.success,
    this.data,
  });

  factory RefundResponse.fromJson(Map<String, dynamic> json) => RefundResponse(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  int? currentPage;
  List<RefundData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<RefundData>.from(json["data"]!.map((x) => RefundData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class RefundData {
  int? id;
  var tripId;
  var userId;
  dynamic reason;
  String? status;
  String? amount;
  String? refundAmount;
  dynamic refundType;
  DateTime? createdAt;
  DateTime? updatedAt;

  RefundData({
    this.id,
    this.tripId,
    this.userId,
    this.reason,
    this.status,
    this.amount,
    this.refundAmount,
    this.refundType,
    this.createdAt,
    this.updatedAt,
  });

  factory RefundData.fromJson(Map<String, dynamic> json) => RefundData(
    id: json["id"],
    tripId: json["trip_id"],
    userId: json["user_id"],
    reason: json["reason"],
    status: json["status"],
    amount: json["amount"],
    refundAmount: json["refund_amount"],
    refundType: json["refund_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_id": tripId,
    "user_id": userId,
    "reason": reason,
    "status": status,
    "amount": amount,
    "refund_amount": refundAmount,
    "refund_type": refundType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
