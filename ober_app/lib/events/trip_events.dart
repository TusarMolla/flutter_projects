


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/events/seo_event.dart';

class TripEvents extends SeoEvent{
}

class InitTripDetails extends TripEvents{
var tripId;
BuildContext context;

InitTripDetails(this.tripId,this.context);
}

class OnCheckTripStatus extends TripEvents{
  VoidCallback? finish;

  OnCheckTripStatus({this.finish});
}

class OnTripStart extends TripEvents{

}
class OnTripCancel extends TripEvents{
  final id;
  BuildContext context;

  OnTripCancel(this.id,this.context);
}

class UpdateDriverLocation extends TripEvents{
  LatLng latLng;

  UpdateDriverLocation(this.latLng);
}
