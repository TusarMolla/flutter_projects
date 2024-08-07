// To parse this JSON data, do
//
//     final tripAcceptedPusherResponse = tripAcceptedPusherResponseFromJson(jsonString);

import 'dart:convert';

TripAcceptedPusherResponse tripAcceptedPusherResponseFromJson(String str) => TripAcceptedPusherResponse.fromJson(json.decode(str));

String tripAcceptedPusherResponseToJson(TripAcceptedPusherResponse data) => json.encode(data.toJson());

class TripAcceptedPusherResponse {
  Trip? trip;
  Passenger? passenger;

  TripAcceptedPusherResponse({
    this.trip,
    this.passenger,
  });

  factory TripAcceptedPusherResponse.fromJson(Map<String, dynamic> json) => TripAcceptedPusherResponse(
    trip: (json["trip_id"]) == null ? null :Trip.fromJson(json["trip_id"]),
    passenger: json["passenger"] == null ? null : Passenger.fromJson(json["passenger"]),
  );

  Map<String, dynamic> toJson() => {
    "trip": trip,
    "passenger": passenger?.toJson(),
  };
}

class Passenger {
  var id;
  var userId;
  String? firstName;
  String? lastName;
  DateTime? dob;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  var isAvailable;

  Passenger({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.dob,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isAvailable,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    phoneNumber: json["phone_number"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    country: json["country"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isAvailable: json["is_available"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "phone_number": phoneNumber,
    "address": address,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "country": country,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_available": isAvailable,
  };
}

class Trip {
  var id;
  var driverId;
  var passengerId;
  String? startLocation;
  String? endLocation;
  DateTime? startTime;
  dynamic endTime;
  String? distance;
  var duration;
  String? fare;
  dynamic paymentMethod;
  String? status;
  dynamic driverRating;
  dynamic passengerRating;
  dynamic tripNotes;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fromLatitudeLongitude;
  String? toLatitudeLongitude;
  dynamic cancelReason;
  dynamic cancelledBy;

  Trip({
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
    this.tripNotes,
    this.createdAt,
    this.updatedAt,
    this.fromLatitudeLongitude,
    this.toLatitudeLongitude,
    this.cancelReason,
    this.cancelledBy,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
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
    tripNotes: json["trip_notes"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    fromLatitudeLongitude: json["from_latitude_longitude"],
    toLatitudeLongitude: json["to_latitude_longitude"],
    cancelReason: json["cancel_reason"],
    cancelledBy: json["cancelled_by"],
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
    "trip_notes": tripNotes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "from_latitude_longitude": fromLatitudeLongitude,
    "to_latitude_longitude": toLatitudeLongitude,
    "cancel_reason": cancelReason,
    "cancelled_by": cancelledBy,
  };
}
