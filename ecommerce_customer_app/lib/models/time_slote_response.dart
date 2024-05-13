// To parse this JSON data, do
//
//     final timeSlotResponse = timeSlotResponseFromJson(jsonString);

import 'dart:convert';

import 'package:grostore/models/product_details_response.dart';

TimeSlotResponse timeSlotResponseFromJson(String str) => TimeSlotResponse.fromJson(json.decode(str));

String timeSlotResponseToJson(TimeSlotResponse data) => json.encode(data.toJson());

class TimeSlotResponse {
  String days;
  List<TimeSlot> timeSlots;

  TimeSlotResponse({
    required this.days,
    required this.timeSlots,
  });

  factory TimeSlotResponse.fromJson(Map<String, dynamic> json) => TimeSlotResponse(
    days: json["days"],
    timeSlots: List<TimeSlot>.from(json["time_slots"].map((x) => TimeSlot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "time_slots": List<dynamic>.from(timeSlots.map((x) => x.toJson())),
  };
}

class TimeSlot {
  var id;
  String timeline;
  var sortingOrder;



  TimeSlot({
    required this.id,
    required this.timeline,
    required this.sortingOrder,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
    id: json["id"],
    timeline: json["timeline"],
    sortingOrder: json["sorting_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "timeline": timeline,
    "sorting_order": sortingOrder,
  };
}
