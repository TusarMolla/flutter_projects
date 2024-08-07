import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ober_app/events/map_events.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/repositories/map_repository.dart';
import 'package:ober_app/states/map_state.dart';

class MapBloc extends Bloc<SeoEvent,MapState>{
  MapBloc():super(MapState.init()){
    on<CameraChangeByUserLocation>((event, emit)async  {
    var tmpData = await state.controller.future;

    var data = await  _getCurrentLocation();
    state.cameraLocation = LatLng(data.latitude, data.longitude);
    state.locationDetails = await _getLocationDetails(state.cameraLocation);
    tmpData.animateCamera(CameraUpdate.newLatLng(state.cameraLocation));
     return emit(state.update(state));
    });
    on<OnPickLocation>((event, emit) => _pickLocation(event,emit));
  }



  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();

  }

  _pickLocation(OnPickLocation location , Emitter emitter)async{
    print("object");
    state.cameraLocation = location.position.target;
    state.locationDetails = await _getLocationDetails(state.cameraLocation);
   return emitter(state.update(state));
  }


Future<String> _getLocationDetails(LatLng latLng)async{
   var response = await MapRepository.formattedAddress(latLng);

   print("result ${response.results == null} ${response.results?.isNotEmpty}");

   if ( response.results!= null && response.results!.isNotEmpty){
     return response.results!.first.formattedAddress!;
   }
   return "Please Pick Address";
  }



}