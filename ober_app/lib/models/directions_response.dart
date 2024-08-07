// To parse this JSON data, do
//
//     final directionsResponse = directionsResponseFromJson(jsonString);

import 'dart:convert';

DirectionsResponse directionsResponseFromJson(String str) => DirectionsResponse.fromJson(json.decode(str));

String directionsResponseToJson(DirectionsResponse data) => json.encode(data.toJson());

class DirectionsResponse {
  List<GeocodedWaypoint>? geocodedWaypoints;
  List<Route>? routes;
  String? status;

  DirectionsResponse({
    this.geocodedWaypoints,
    this.routes,
    this.status,
  });

  factory DirectionsResponse.fromJson(Map<String, dynamic> json) => DirectionsResponse(
    geocodedWaypoints: json["geocoded_waypoints"] == null ? [] : List<GeocodedWaypoint>.from(json["geocoded_waypoints"]!.map((x) => GeocodedWaypoint.fromJson(x))),
    routes: json["routes"] == null ? [] : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "geocoded_waypoints": geocodedWaypoints == null ? [] : List<dynamic>.from(geocodedWaypoints!.map((x) => x.toJson())),
    "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x.toJson())),
    "status": status,
  };
}

class GeocodedWaypoint {
  String? geocoderStatus;
  String? placeId;
  List<String>? types;

  GeocodedWaypoint({
    this.geocoderStatus,
    this.placeId,
    this.types,
  });

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) => GeocodedWaypoint(
    geocoderStatus: json["geocoder_status"],
    placeId: json["place_id"],
    types: json["types"] == null ? [] : List<String>.from(json["types"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "geocoder_status": geocoderStatus,
    "place_id": placeId,
    "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
  };
}

class Route {
  Bounds? bounds;
  String? copyrights;
  List<Leg>? legs;
  Polyline? overviewPolyline;
  String? summary;
  List<dynamic>? warnings;
  List<dynamic>? waypointOrder;

  Route({
    this.bounds,
    this.copyrights,
    this.legs,
    this.overviewPolyline,
    this.summary,
    this.warnings,
    this.waypointOrder,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
    copyrights: json["copyrights"],
    legs: json["legs"] == null ? [] : List<Leg>.from(json["legs"]!.map((x) => Leg.fromJson(x))),
    overviewPolyline: json["overview_polyline"] == null ? null : Polyline.fromJson(json["overview_polyline"]),
    summary: json["summary"],
    warnings: json["warnings"] == null ? [] : List<dynamic>.from(json["warnings"]!.map((x) => x)),
    waypointOrder: json["waypoint_order"] == null ? [] : List<dynamic>.from(json["waypoint_order"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bounds": bounds?.toJson(),
    "copyrights": copyrights,
    "legs": legs == null ? [] : List<dynamic>.from(legs!.map((x) => x.toJson())),
    "overview_polyline": overviewPolyline?.toJson(),
    "summary": summary,
    "warnings": warnings == null ? [] : List<dynamic>.from(warnings!.map((x) => x)),
    "waypoint_order": waypointOrder == null ? [] : List<dynamic>.from(waypointOrder!.map((x) => x)),
  };
}

class Bounds {
  Northeast? northeast;
  Northeast? southwest;

  Bounds({
    this.northeast,
    this.southwest,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    northeast: json["northeast"] == null ? null : Northeast.fromJson(json["northeast"]),
    southwest: json["southwest"] == null ? null : Northeast.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast?.toJson(),
    "southwest": southwest?.toJson(),
  };
}

class Northeast {
  double? lat;
  double? lng;

  Northeast({
    this.lat,
    this.lng,
  });

  factory Northeast.fromJson(Map<String, dynamic> json) => Northeast(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Leg {
  Distance? distance;
  Distance? duration;
  String? endAddress;
  Northeast? endLocation;
  String? startAddress;
  Northeast? startLocation;
  List<Step>? steps;
  List<dynamic>? trafficSpeedEntry;
  List<dynamic>? viaWaypoint;

  Leg({
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
    this.trafficSpeedEntry,
    this.viaWaypoint,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    distance: json["distance"] == null ? null : Distance.fromJson(json["distance"]),
    duration: json["duration"] == null ? null : Distance.fromJson(json["duration"]),
    endAddress: json["end_address"],
    endLocation: json["end_location"] == null ? null : Northeast.fromJson(json["end_location"]),
    startAddress: json["start_address"],
    startLocation: json["start_location"] == null ? null : Northeast.fromJson(json["start_location"]),
    steps: json["steps"] == null ? [] : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
    trafficSpeedEntry: json["traffic_speed_entry"] == null ? [] : List<dynamic>.from(json["traffic_speed_entry"]!.map((x) => x)),
    viaWaypoint: json["via_waypoint"] == null ? [] : List<dynamic>.from(json["via_waypoint"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance?.toJson(),
    "duration": duration?.toJson(),
    "end_address": endAddress,
    "end_location": endLocation?.toJson(),
    "start_address": startAddress,
    "start_location": startLocation?.toJson(),
    "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x.toJson())),
    "traffic_speed_entry": trafficSpeedEntry == null ? [] : List<dynamic>.from(trafficSpeedEntry!.map((x) => x)),
    "via_waypoint": viaWaypoint == null ? [] : List<dynamic>.from(viaWaypoint!.map((x) => x)),
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

class Step {
  Distance? distance;
  Distance? duration;
  Northeast? endLocation;
  String? htmlInstructions;
  Polyline? polyline;
  Northeast? startLocation;
  String? travelMode;
  String? maneuver;

  Step({
    this.distance,
    this.duration,
    this.endLocation,
    this.htmlInstructions,
    this.polyline,
    this.startLocation,
    this.travelMode,
    this.maneuver,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    distance: json["distance"] == null ? null : Distance.fromJson(json["distance"]),
    duration: json["duration"] == null ? null : Distance.fromJson(json["duration"]),
    endLocation: json["end_location"] == null ? null : Northeast.fromJson(json["end_location"]),
    htmlInstructions: json["html_instructions"],
    polyline: json["polyline"] == null ? null : Polyline.fromJson(json["polyline"]),
    startLocation: json["start_location"] == null ? null : Northeast.fromJson(json["start_location"]),
    travelMode: json["travel_mode"],
    maneuver: json["maneuver"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance?.toJson(),
    "duration": duration?.toJson(),
    "end_location": endLocation?.toJson(),
    "html_instructions": htmlInstructions,
    "polyline": polyline?.toJson(),
    "start_location": startLocation?.toJson(),
    "travel_mode": travelMode,
    "maneuver": maneuver,
  };
}

class Polyline {
  String? points;

  Polyline({
    this.points,
  });

  factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "points": points,
  };
}
