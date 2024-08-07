



import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/events/seo_event.dart';

class ChangeCameraPosition extends SeoEvent{

}

class CameraChangeByUserLocation extends SeoEvent{

}

class OnPickLocation extends SeoEvent{
  CameraPosition position;
  OnPickLocation(this.position);
}

