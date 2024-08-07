// To parse this JSON data, do
//
//     final locationDetailsResponse = locationDetailsResponseFromJson(jsonString);

import 'dart:convert';

LocationDetailsResponse locationDetailsResponseFromJson(String str) => LocationDetailsResponse.fromJson(json.decode(str));

String locationDetailsResponseToJson(LocationDetailsResponse data) => json.encode(data.toJson());

class LocationDetailsResponse {
  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;

  LocationDetailsResponse({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  factory LocationDetailsResponse.fromJson(Map<String, dynamic> json) => LocationDetailsResponse(
    htmlAttributions: json["html_attributions"] == null ? [] : List<dynamic>.from(json["html_attributions"]!.map((x) => x)),
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "html_attributions": htmlAttributions == null ? [] : List<dynamic>.from(htmlAttributions!.map((x) => x)),
    "result": result?.toJson(),
    "status": status,
  };
}

class Result {
  Geometry? geometry;
  String? name;

  Result({
    this.geometry,
    this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry?.toJson(),
    "name": name,
  };
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({
    this.location,
    this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    viewport: json["viewport"] == null ? null : Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "viewport": viewport?.toJson(),
  };
}

class Location {
  double? lat;
  double? lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: json["northeast"] == null ? null : Location.fromJson(json["northeast"]),
    southwest: json["southwest"] == null ? null : Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast?.toJson(),
    "southwest": southwest?.toJson(),
  };
}
