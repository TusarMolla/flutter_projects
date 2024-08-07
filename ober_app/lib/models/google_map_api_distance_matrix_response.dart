// To parse this JSON data, do
//
//     final googleMapDistanceMatrixResponse = googleMapDistanceMatrixResponseFromJson(jsonString);

import 'dart:convert';

GoogleMapDistanceMatrixResponse googleMapDistanceMatrixResponseFromJson(String str) => GoogleMapDistanceMatrixResponse.fromJson(json.decode(str));

String googleMapDistanceMatrixResponseToJson(GoogleMapDistanceMatrixResponse data) => json.encode(data.toJson());

class GoogleMapDistanceMatrixResponse {
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<Row>? rows;
  String? status;

  GoogleMapDistanceMatrixResponse({
    this.destinationAddresses,
    this.originAddresses,
    this.rows,
    this.status,
  });

  factory GoogleMapDistanceMatrixResponse.fromJson(Map<String, dynamic> json) => GoogleMapDistanceMatrixResponse(
    destinationAddresses: json["destination_addresses"] == null ? [] : List<String>.from(json["destination_addresses"]!.map((x) => x)),
    originAddresses: json["origin_addresses"] == null ? [] : List<String>.from(json["origin_addresses"]!.map((x) => x)),
    rows: json["rows"] == null ? [] : List<Row>.from(json["rows"]!.map((x) => Row.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "destination_addresses": destinationAddresses == null ? [] : List<dynamic>.from(destinationAddresses!.map((x) => x)),
    "origin_addresses": originAddresses == null ? [] : List<dynamic>.from(originAddresses!.map((x) => x)),
    "rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toJson())),
    "status": status,
  };
}

class Row {
  List<Element>? elements;

  Row({
    this.elements,
  });

  factory Row.fromJson(Map<String, dynamic> json) => Row(
    elements: json["elements"] == null ? [] : List<Element>.from(json["elements"]!.map((x) => Element.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "elements": elements == null ? [] : List<dynamic>.from(elements!.map((x) => x.toJson())),
  };
}

class Element {
  Distance? distance;
  Distance? duration;
  String? status;

  Element({
    this.distance,
    this.duration,
    this.status,
  });

  factory Element.fromJson(Map<String, dynamic> json) => Element(
    distance: json["distance"] == null ? null : Distance.fromJson(json["distance"]),
    duration: json["duration"] == null ? null : Distance.fromJson(json["duration"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance?.toJson(),
    "duration": duration?.toJson(),
    "status": status,
  };
}

class Distance {
  String? text;
  int? value;

  Distance({
    this.text,
    this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
    text: json["text"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "value": value,
  };
}
