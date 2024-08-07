
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/events/booking_screen_events.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/seo_date_formatter.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/repositories/trip_repository.dart';
import 'package:ober_app/states/booking_screen_state.dart';
import 'package:ober_app/ui/pages/main.dart';
import 'package:ober_app/ui/pages/trip/trip_request_details.dart';

class BookingScreenBloc extends Bloc<BookingScreenEvent,BookingScreenState>{


  BookingScreenBloc():super(BookingScreenState.init()) {
    on<InitState>((event, emit) => _setPolyline(event, emit));

  }


  _setPolyline(InitState event, Emitter emit) async {
    state.polyline = {};
    state.polylineCoordinates = [];
    await _getPolyline(event.pickUp,event.dropOff);
    await _requestForVehicleCategory(emit, event.context);
    return emit(state.update(state));
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: ThemeConfig.accentColor,
        width: 5,
        points: state.polylineCoordinates);
    state.polyline[id] = polyline;
  }

  _getPolyline(LatLng pickup,dropOff) async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      AppConfig.googleMapAPIKey,
      PointLatLng(pickup.latitude, pickup.longitude),
      PointLatLng(
          dropOff.latitude, dropOff.longitude),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")
      // ]
    );
    state.tripLocationData = result;
    state.totalDistance= (result.distanceValue??0)/1000;
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        state.polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  _requestForVehicleCategory(Emitter emitter,BuildContext context)async{
    Map<String,dynamic> data= {
      "start_location":state.tripLocationData?.startAddress,
      "end_location":state.tripLocationData?.endAddress,
      // "start_time":DateTime.now().yearMonthDay(),
      "distance":state.totalDistance,
      "duration":state.tripLocationData?.durationValue??0,
      // "trip_notes":Smooth ride, no issues.,
      "from_latitude_longitude":"${state.tripLocationData?.points.first.latitude}, ${state.tripLocationData?.points.first.longitude}",
      "to_latitude_longitude":"${state.tripLocationData?.points.last.latitude}, ${state.tripLocationData?.points.last.longitude}",
    };
    var response = await TripRepository.requestVehicleCategory(data);
    state.vehicleCategories = response.categories??[];
    state.tripId = response.tripId;
    emitter(state.update(state));
  }


}