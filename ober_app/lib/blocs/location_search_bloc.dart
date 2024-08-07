import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_models/ober_address_model.dart';
import 'package:ober_app/events/location_search_events.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/models/auto_complete_response.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/repositories/map_repository.dart';
import 'package:ober_app/states/location_search_state.dart';
import 'package:ober_app/ui/pages/search_location/booking_screen.dart';

class LocationSearchBloc extends Bloc<SeoEvent, LocationSearchState> {
  LocationSearchBloc() : super(LocationSearchState.init()) {
    on<SetUserCurrentLocation>((event, emit) => setCurrentLocation(emit));
    on<OnSetBottomShowHide>(
        (event, emit) => _changeBottomSheetShowHide(event, emit));
    on<OnChangeLocationField>(
        (event, emit) => _onChangeLocationField(event, emit));
    on<OnChangeCameraPosition>((event, emit) => _onMoveCamera(event, emit));

    on<OnSearchLocation>((event, emit) => _authCompleteLocation(event, emit));
    on<OnSelectedAutoLocation>((event, emit) => _onSelectedAutoLocation(event, emit));

    on<OnPressDone>((event, emit) => _done(event,emit));
  }


  _done(OnPressDone event,Emitter emit){
    if(state.dropOffAddress == null){
      state.focusNode.requestFocus();
      return;
    }

    SEORoute.go(event.context, BookingScreen(pickUp: state.pickupAddress!.position, dropOff: state.dropOffAddress!.position));

    return emit(state.update(state));
  }


  _onSelectedAutoLocation(OnSelectedAutoLocation event,Emitter emit)async{
    state.selectedLocation = event.location;
    var tmp = await _getLatLngFromLocationId(event.location.placeId!);
    if(!state.focusNode.hasFocus){
      state.pickupAddress = tmp;
      state.pickupLocationController.text = tmp.name;
      state.dropOffLocationController.clear();
      state.autoCompleteLocations.clear();
      state.focusNode.requestFocus();
    }else{
      state.dropOffAddress = tmp;
      state.dropOffLocationController.text = tmp.name;
      SEORoute.go(event.context, BookingScreen(pickUp: state.pickupAddress!.position, dropOff: state.dropOffAddress!.position));
    }
    return emit(state.update(state));
  }

  Future<OberAddressModel> _getLatLngFromLocationId(String locationId)async{
     var tmp = await MapRepository.placeDetails(locationId);
     if(tmp.status != "OK"){
       return Future.error("NOT_FOUND.");
     }

     return OberAddressModel(position: LatLng((tmp.result!.geometry!.location!.lat!),(tmp.result!.geometry!.location!.lng!)), name: tmp.result!.name!);


  }

  _authCompleteLocation(OnSearchLocation event,Emitter emit)async{
    var tmp = await _getAutoCompleteLocations(event.text);
    state.autoCompleteLocations.clear();
    state.autoCompleteLocations.addAll(tmp);
    return emit(state.update(state));
  }



  _onMoveCamera(OnChangeCameraPosition event, Emitter emit) async {
    var tmpData = await _getLocationDetails(event.position.target);

    if (state.currentActiveField == ActiveLocationField.PickUp) {
      state.pickupAddress = OberAddressModel(position: event.position.target,name: tmpData);
      state.pickupLocationController.text = tmpData;
    } else {
      state.dropOffAddress = OberAddressModel(position:  event.position.target,name: tmpData);
      state.dropOffLocationController.text = tmpData;
    }
    state.isShownBottomSheet=false;

    return emit(state.update(state));
  }

  _onChangeLocationField(OnChangeLocationField event, Emitter emit) {
    state.isShownBottomSheet = true;
    if (state.draggableController.isAttached) {
      state.draggableController.reset();
    }
    state.currentActiveField=event.field;
    state.pickupLocationController.text = state.pickupAddress?.name??"";
    state.dropOffLocationController.text = state.dropOffAddress?.name??"";
    return emit(state.update(state));
  }

  _changeBottomSheetShowHide(OnSetBottomShowHide event, Emitter emit) {
    FocusManager.instance.primaryFocus?.unfocus();
    state.isShownBottomSheet = event.data;
    return emit(state.update(state));
  }

  setCurrentLocation(Emitter emit) async {
    var tmpData = await getCurrentLocation;
    state.currentLocation = tmpData;
    state.pickupLocationController.text =
        await _getLocationDetails(state.currentLocation!);
    state.pickupAddress = OberAddressModel(position: tmpData,name:state.pickupLocationController.text );
    return emit(state.update(state));
  }

  Future<String> _getLocationDetails(LatLng latLng) async {
    var response = await MapRepository.formattedAddress(latLng);

    print("result ${response.results == null} ${response.results?.isNotEmpty}");

    if (response.results != null && response.results!.isNotEmpty) {
      return response.results!.first.formattedAddress!;
    }
    return "Please Pick Address";
  }

/*
  Future<Set<Polyline>> _getPolyline() async {

/*

    Set<Polyline> tmp = {};


    var response = await MapRepository.directions(
        start: state.pickupLatLng!, end: state.dropOffLatLng!);

    print("result ${response.status == null} ${response.status?.isNotEmpty}");


    List<LatLng> points = [];
    if (response.status != null && response.status!.isNotEmpty) {
      response.routes?.first.legs?.first.steps?.forEach((element) {
        points.add(LatLng(element.startLocation!.lat!,element.startLocation!.lng!),);
        points.add(LatLng(element.endLocation!.lat!,element.endLocation!.lng!),);

      });
    }

    tmp.add(

        Polyline(
            polylineId: PolylineId("myPolyline"),
            color:ThemeConfig.accentColor,
            jointType: JointType.bevel,
            width: 5,
            points:points));
*/
/*
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(AppConfig.googleMapAPIKey,
        PointLatLng(state.pickupLatLng!.latitude,state.pickupLatLng!.longitude),PointLatLng(state.dropOffLatLng!.latitude,state.dropOffLatLng!.longitude));
*/
    return tmp;
  }
*/


 Future<List<Prediction>> _getAutoCompleteLocations(text)async{
    var tempRes = await MapRepository.search(text);

    return tempRes.predictions??[];

  }

}
