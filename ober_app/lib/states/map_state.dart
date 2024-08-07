import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/models/geo_coding_response.dart';

class MapState{
  LatLng cameraLocation;
  int count=0;
  String locationDetails;

  Completer<GoogleMapController> controller;
  MapState({required this.cameraLocation,required this.count,required this.controller,required this.locationDetails});

  MapState.init():cameraLocation=const LatLng(37.41806208182146, -122.08083149045704),
  count = 0,
  controller  = Completer<GoogleMapController>(),
  locationDetails = ""
  ;

  update(MapState oldState){
    return MapState(cameraLocation: oldState.cameraLocation,count: oldState.count,controller: oldState.controller,locationDetails: oldState.locationDetails);
  }
}