import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/models/trip_detail_response.dart';

class TripState {
  TripDetailsResponse? details;
  TextEditingController cancelReasonController ;
  bool isTripDetailsInit;
  Set<Marker> markers ;
  Map<PolylineId, Polyline> polyline;
  LatLng? currentDriverLatLng;
  LatLng? startLatLng;
  LatLng? endLatLng;

  Completer<GoogleMapController> controller;

  int? currentTripId;

  TripState(
      {required this.details,
      required this.isTripDetailsInit,
      required this.currentTripId,
      required this.currentDriverLatLng,
      required this.controller,
      // required this.polylineCoordinates,
        required this.polyline,
        required this.markers,
        required this.startLatLng,
        required this.endLatLng,
        required this.cancelReasonController,
      });

  TripState.init()
      : isTripDetailsInit = false,
        controller = Completer<GoogleMapController>(),
  polyline = {},
        cancelReasonController = TextEditingController(),
  markers = {}
  // polylineCoordinates = []
  ;

  TripState update(TripState state) {
    return TripState(
        details: state.details,
        isTripDetailsInit: state.isTripDetailsInit,
        currentTripId: state.currentTripId,
        currentDriverLatLng: state.currentDriverLatLng,
      controller: state.controller,
      // polylineCoordinates: state.polylineCoordinates,
      polyline: state.polyline,
      markers: state.markers,
      startLatLng: state.startLatLng,
      endLatLng: state.endLatLng,
      cancelReasonController: state.cancelReasonController

    );
  }
}
