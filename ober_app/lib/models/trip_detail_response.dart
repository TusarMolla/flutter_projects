// To parse this JSON data, do
//
//     final tripDetailsResponse = tripDetailsResponseFromJson(jsonString);

import 'dart:convert';

TripDetailsResponse tripDetailsResponseFromJson(String str) => TripDetailsResponse.fromJson(json.decode(str));

String tripDetailsResponseToJson(TripDetailsResponse data) => json.encode(data.toJson());

class TripDetailsResponse {
  bool? success;
  Trip? trip;
  Driver? driver;
  Passenger? passenger;
  List<dynamic>? complain;
  Vehicle? vehicle;

  TripDetailsResponse({
    this.success,
    this.trip,
    this.driver,
    this.passenger,
    this.complain,
    this.vehicle,
  });

  factory TripDetailsResponse.fromJson(Map<String, dynamic> json) => TripDetailsResponse(
    success: json["success"],
    trip: json["trip"] == null ? null : Trip.fromJson(json["trip"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    passenger: json["passenger"] == null ? null : Passenger.fromJson(json["passenger"]),
    complain: json["complain"] == null ? [] : List<dynamic>.from(json["complain"]!.map((x) => x)),
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "trip": trip?.toJson(),
    "driver": driver?.toJson(),
    "passenger": passenger?.toJson(),
    "complain": complain == null ? [] : List<dynamic>.from(complain!.map((x) => x)),
    "vehicle": vehicle?.toJson(),
  };
}

class Driver {
  var id;
  var userId;
  dynamic reviewedBy;
  var vehicleCategoryId;
  String? firstName;
  String? lastName;
  DateTime? dob;
  String? phoneNumber;
  String? address;
  dynamic city;
  dynamic state;
  dynamic postalCode;
  dynamic country;
  String? licenseNumber;
  DateTime? licenseIssueDate;
  DateTime? licenseExpiryDate;
  String? licenseClass;
  dynamic licenseImage;
  dynamic backgroundCheckStatus;
  DateTime? submissionDate;
  dynamic reviewDate;
  dynamic remarks;
  String? status;
  dynamic profileVerified;
  var isAvailable;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? latitude;
  String? longitude;
  dynamic photo;

  Driver({
    this.id,
    this.userId,
    this.reviewedBy,
    this.vehicleCategoryId,
    this.firstName,
    this.lastName,
    this.dob,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.licenseNumber,
    this.licenseIssueDate,
    this.licenseExpiryDate,
    this.licenseClass,
    this.licenseImage,
    this.backgroundCheckStatus,
    this.submissionDate,
    this.reviewDate,
    this.remarks,
    this.status,
    this.profileVerified,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
    this.photo,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    userId: json["user_id"],
    reviewedBy: json["reviewed_by"],
    vehicleCategoryId: json["vehicle_category_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    phoneNumber: json["phone_number"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    country: json["country"],
    licenseNumber: json["license_number"],
    licenseIssueDate: json["license_issue_date"] == null ? null : DateTime.parse(json["license_issue_date"]),
    licenseExpiryDate: json["license_expiry_date"] == null ? null : DateTime.parse(json["license_expiry_date"]),
    licenseClass: json["license_class"],
    licenseImage: json["license_image"],
    backgroundCheckStatus: json["background_check_status"],
    submissionDate: json["submission_date"] == null ? null : DateTime.parse(json["submission_date"]),
    reviewDate: json["review_date"],
    remarks: json["remarks"],
    status: json["status"],
    profileVerified: json["profile_verified"],
    isAvailable: json["is_available"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    latitude: json["latitude"],
    longitude: json["longitude"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "reviewed_by": reviewedBy,
    "vehicle_category_id": vehicleCategoryId,
    "first_name": firstName,
    "last_name": lastName,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "phone_number": phoneNumber,
    "address": address,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "country": country,
    "license_number": licenseNumber,
    "license_issue_date": "${licenseIssueDate!.year.toString().padLeft(4, '0')}-${licenseIssueDate!.month.toString().padLeft(2, '0')}-${licenseIssueDate!.day.toString().padLeft(2, '0')}",
    "license_expiry_date": "${licenseExpiryDate!.year.toString().padLeft(4, '0')}-${licenseExpiryDate!.month.toString().padLeft(2, '0')}-${licenseExpiryDate!.day.toString().padLeft(2, '0')}",
    "license_class": licenseClass,
    "license_image": licenseImage,
    "background_check_status": backgroundCheckStatus,
    "submission_date": submissionDate?.toIso8601String(),
    "review_date": reviewDate,
    "remarks": remarks,
    "status": status,
    "profile_verified": profileVerified,
    "is_available": isAvailable,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "latitude": latitude,
    "longitude": longitude,
    "photo": photo,
  };
}

class Passenger {
  var id;
  var userId;
  String? firstName;
  String? lastName;
  DateTime? dob;
  dynamic image;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  var isAvailable;

  Passenger({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.dob,
    this.image,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
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
    image: json["image"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    country: json["country"],
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
    "image": image,
    "phone_number": phoneNumber,
    "address": address,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "country": country,
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
  dynamic driverComment;
  dynamic passengerComment;
  dynamic tripNotes;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fromLatitudeLongitude;
  String? toLatitudeLongitude;
  dynamic cancelReason;
  var cancelledBy;

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
    this.driverComment,
    this.passengerComment,
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
    driverComment: json["driver_comment"],
    passengerComment: json["passenger_comment"],
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
    "driver_comment": driverComment,
    "passenger_comment": passengerComment,
    "trip_notes": tripNotes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "from_latitude_longitude": fromLatitudeLongitude,
    "to_latitude_longitude": toLatitudeLongitude,
    "cancel_reason": cancelReason,
    "cancelled_by": cancelledBy,
  };
}

class Vehicle {
  String? vehicleName;
  String? vehicleLicenseNumber;

  Vehicle({
    this.vehicleName,
    this.vehicleLicenseNumber,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    vehicleName: json["vehicle_name"],
    vehicleLicenseNumber: json["vehicle_license_number"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_name": vehicleName,
    "vehicle_license_number": vehicleLicenseNumber,
  };
}
