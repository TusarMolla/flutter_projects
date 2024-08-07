// To parse this JSON data, do
//
//     final tripListResponse = tripListResponseFromJson(jsonString);

import 'dart:convert';

TripListResponse tripListResponseFromJson(String str) => TripListResponse.fromJson(json.decode(str));

String tripListResponseToJson(TripListResponse data) => json.encode(data.toJson());

class TripListResponse {
  Trips? trips;

  TripListResponse({
    this.trips,
  });

  factory TripListResponse.fromJson(Map<String, dynamic> json) => TripListResponse(
    trips: json["trips"] == null ? null : Trips.fromJson(json["trips"]),
  );

  Map<String, dynamic> toJson() => {
    "trips": trips?.toJson(),
  };
}

class Trips {
  var currentPage;
  List<TripData>? data;
  String? firstPageUrl;
  var from;
  var lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  var perPage;
  dynamic prevPageUrl;
  var to;
  var total;

  Trips({
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

  factory Trips.fromJson(Map<String, dynamic> json) => Trips(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<TripData>.from(json["data"]!.map((x) => TripData.fromJson(x))),
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

class TripData {
  var id;
  var driverId;
  var passengerId;
  var startLocation;
  var endLocation;
  DateTime? startTime;
  dynamic endTime;
  String? distance;
  var duration;
  String? fare;
  dynamic paymentMethod;
  String? status;
  dynamic driverRating;
  dynamic passengerRating;
  dynamic passengerComment;
  dynamic driverComment;
  dynamic tripNotes;
  DateTime? createdAt;
  DateTime? updatedAt;
  var fromLatitudeLongitude;
  var toLatitudeLongitude;
  dynamic cancelReason;
  dynamic cancelledBy;
  dynamic refundStatus;

  TripData({
    this.id,
    this.driverId,
    this.passengerId,
    this.startLocation,
    this.endLocation,
    this.startTime,
    this.endTime,
    this.distance,
    this.duration,
    this.fare,
    this.paymentMethod,
    this.status,
    this.driverRating,
    this.passengerRating,
    this.passengerComment,
    this.driverComment,
    this.tripNotes,
    this.createdAt,
    this.updatedAt,
    this.fromLatitudeLongitude,
    this.toLatitudeLongitude,
    this.cancelReason,
    this.cancelledBy,
    this.refundStatus,
  });

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
    id: json["id"],
    driverId: json["driver_id"],
    passengerId: json["passenger_id"],
    startLocation: json["start_location"],
    endLocation: json["end_location"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"],
    distance: json["distance"],
    duration: json["duration"],
    fare: json["fare"],
    paymentMethod: json["payment_method"],
    status: json["status"],
    driverRating: json["driver_rating"],
    passengerRating: json["passenger_rating"],
    passengerComment: json["passenger_comment"],
    driverComment: json["driver_comment"],
    tripNotes: json["trip_notes"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    fromLatitudeLongitude: json["from_latitude_longitude"],
    toLatitudeLongitude: json["to_latitude_longitude"],
    cancelReason: json["cancel_reason"],
    cancelledBy: json["cancelled_by"],
    refundStatus: json["refund_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "passenger_id": passengerId,
    "start_location": startLocation,
    "end_location": endLocation,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime,
    "distance": distance,
    "duration": duration,
    "fare": fare,
    "payment_method": paymentMethod,
    "status": status,
    "driver_rating": driverRating,
    "passenger_rating": passengerRating,
    "passenger_comment": passengerComment,
    "driver_comment": driverComment,
    "trip_notes": tripNotes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "from_latitude_longitude":fromLatitudeLongitude,
    "to_latitude_longitude": toLatitudeLongitude,
    "cancel_reason": cancelReason,
    "cancelled_by": cancelledBy,
    "refund_status": refundStatus,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
