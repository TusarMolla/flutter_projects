import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/models/trip_request_response.dart';

class BookingScreenState {
  Map<PolylineId, Polyline> polyline;
  List<LatLng> polylineCoordinates;
  List<VehicleCategory> vehicleCategories;
  int? tripId;
  Completer<GoogleMapController> mapController;
  double totalDistance;
  PolylineResult? tripLocationData;


  BookingScreenState(
      {required this.polyline,
      required this.polylineCoordinates,
      required this.mapController,
      required this.totalDistance,
        required this.vehicleCategories,
       required this.tripId,
      required this.tripLocationData});

  BookingScreenState.init()
      : polyline = {},
        polylineCoordinates = [],
        totalDistance = 0.0,
  vehicleCategories = [],
        mapController = Completer<GoogleMapController>();

  update(BookingScreenState state) {
    return BookingScreenState(
      polyline: state.polyline,
      polylineCoordinates: state.polylineCoordinates,
      mapController: state.mapController,
      totalDistance: state.totalDistance,
      tripLocationData: state.tripLocationData,
      vehicleCategories: state.vehicleCategories,
      tripId: state.tripId
    );
  }
}
