


import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/events/seo_event.dart';



class BookingScreenEvent extends SeoEvent{

}

class MarkPolyline extends BookingScreenEvent{
  LatLng pickUp,dropOff;
  MarkPolyline({required this.pickUp,required this.dropOff});
}

class InitState extends BookingScreenEvent{
  LatLng pickUp,dropOff;
  BuildContext context;

  InitState({required this.pickUp,required this.dropOff,required this.context});
}

