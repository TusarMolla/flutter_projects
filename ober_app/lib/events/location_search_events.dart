import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/models/auto_complete_response.dart';
import 'package:ober_app/states/location_search_state.dart';

class CameraMoveByCurrentLocation extends SeoEvent{

}

class SetUserCurrentLocation extends SeoEvent{

}

class OnChangeCameraPosition extends SeoEvent{
  CameraPosition position;
  OnChangeCameraPosition(this.position);
}

class OnSetBottomShowHide extends SeoEvent {
  bool data;
  OnSetBottomShowHide(this.data);
}


class OnChangeLocationField extends SeoEvent{

  ActiveLocationField field;

  OnChangeLocationField(this.field);
}

class OnSearchLocation extends SeoEvent{
  String text;
  OnSearchLocation(this.text);
}

class OnSelectedAutoLocation extends SeoEvent{
  Prediction location;
  BuildContext context;
  OnSelectedAutoLocation(this.location,this.context);
}


class OnPressDone extends SeoEvent{
  BuildContext context;

  OnPressDone(this.context);
}

