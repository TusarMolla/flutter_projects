import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/blocs/trip_pay_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/dummy_data.dart';
import 'package:ober_app/events/trip_events.dart';
import 'package:ober_app/events/trip_pay_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/main.dart';
import 'package:ober_app/others/seo_pusher.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/repositories/trip_repository.dart';
import 'package:ober_app/states/trip_state.dart';
import 'package:ober_app/ui/pages/main.dart';

class TripBloc extends Bloc<TripEvents,TripState>{
  TripBloc():super(TripState.init()){
    on<InitTripDetails>((event, emit) => _getTripDetails(emit, event.tripId,event.context));
    on<OnTripCancel>((event, emit) => _onTripCancel(emit, event));
    on<OnCheckTripStatus>((event, emit)async {
         await _checkTripStatus();
         SeoPusher.tripCancel(tripId: state.currentTripId.toString());
         SeoPusher.tripStart(tripId: state.currentTripId.toString());
         SeoPusher.tripComplete(tripId: state.currentTripId.toString());
         emit(state.update(state));
         if(event.finish !=null) {
        event.finish!();
      }
    });
    on<UpdateDriverLocation>((event, emit) => _updateDriverLocation(emit,event));
  }

  _getTripDetails(Emitter emit,id,BuildContext context)async{
    var res = await TripRepository.tripDetails(id);
    showTripAutoReloadReq(id,context);
    state.isTripDetailsInit = true;
    state.details =res;
    SeoPusher.fetchDriverLocation(driverID: (res.driver?.userId??0).toString());
   await _setPolyline();
    return emit(state.update(state));
  }

  _onTripCancel(Emitter emit,OnTripCancel event)async{
    if(state.cancelReasonController.text.trim().isEmpty){
      SEOToast.show(event.context, "Cancel Reason is required");
      return;
    }
    Loader.show(event.context);
    var res = await TripRepository.tripCancel(event.id,state.cancelReasonController.text.trim());
    Loader.hide();

    state.update(TripState.init());
    await _checkTripStatus();
    SEORoute.goAndRemoveAll(event.context, MainPage());
    return emit(state.update(state));
  }

    _checkTripStatus()async{
    var res = await TripRepository.checkStatus();
    state.currentTripId =res.data?.id;
  }


_updateDriverLocation(Emitter emit,UpdateDriverLocation event)async{
 var tmpIcon = await rootBundle.load(getAssetIcon("map_car.png"));
  var startIcon = tmpIcon.buffer.asUint8List();

  // dummy driver location
  /*if(DummyData.iniIndex==DummyData.lastIndex){
    DummyData.iniIndex =0;
  }else{
    DummyData.iniIndex +=1;
  }*/
 // state.markers.clear();
state.currentDriverLatLng = event.latLng;
  print("driver marker ${state.currentDriverLatLng}");
 state.markers.add(Marker(markerId: const MarkerId("driver-location"),
     // anchor: Offset(0.2, 0.8),
     icon: BitmapDescriptor.fromBytes(startIcon),
     infoWindow: InfoWindow(title: "Driver",snippet: "Driver"),
     // anchor:Offset(0, 0),
     // rotation: 45,
     position: event.latLng, alpha: 1));
 /*var marker =  state.markers.where((element) => element.markerId==MarkerId("driver-location"));
 if(marker.isEmpty) {
   state.markers.add(Marker(markerId: const MarkerId("driver-location"),
       // anchor: Offset(0.2, 0.8),
       icon: BitmapDescriptor.fromBytes(startIcon, size: Size(128, 128)),
       position: state.startLatLng!, alpha: 1));
 }else{
   marker.first.copyWith(positionParam: state.startLatLng!);
 }*/

 emit(state.update(state));
}

  _setPolyline() async {
    state.polyline = {};
    // state.polylineCoordinates = [];

    List tmpFrom = (state.details?.trip?.fromLatitudeLongitude??"").split(", ");
    List<String> tmpTo = (state.details?.trip?.toLatitudeLongitude??"").split(", ");
    print(tmpTo.toString());
    print(tmpTo[0]);
    print(tmpTo[1]);

    if(tmpFrom.isNotEmpty && tmpTo.isNotEmpty) {
      String lat = tmpFrom[0];
      String lng = tmpFrom[1];
      String toLat = tmpTo[0];
      String toLng = tmpTo[1];
       state.startLatLng = LatLng(double.parse(lat),double.parse(lng));
       state.endLatLng = LatLng(double.parse(toLat),double.parse(toLng));

      var tmpIcon = await rootBundle.load(getAssetImage("flag.png"));
      var endIcon = tmpIcon.buffer.asUint8List();
       tmpIcon = await rootBundle.load(getAssetImage("start.png"));
      var startIcon = tmpIcon.buffer.asUint8List();
      state.markers.clear();
      state.markers.add(Marker(markerId: MarkerId("startId"),
          anchor: Offset(0.2, 0.8),
          icon:BitmapDescriptor.fromBytes(startIcon,size: Size(128, 128)),
          position: state.startLatLng!,alpha: 1 ));
      state.markers.add(Marker(
          anchor: Offset(0.2, 0.8),
          markerId: MarkerId("endId"),icon:BitmapDescriptor.fromBytes(endIcon,size: Size(128, 128)),position: state.endLatLng! ));
      await _getPolyline(state.startLatLng!,state.endLatLng!);
    }
  }

  _addPolyLine(List<LatLng> polylineCoordinates) async{

    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: ThemeConfig.accentColor,
        width: 5,
        points: polylineCoordinates);
    state.polyline[id] = polyline;
  }

  _getPolyline(LatLng pickup,LatLng dropOff) async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      AppConfig.googleMapAPIKey,
      PointLatLng(pickup.latitude, pickup.longitude),
      PointLatLng(
          dropOff.latitude, dropOff.longitude),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")
      // ]
    );

    List<LatLng> polylineCoordinates =[];

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
   await _addPolyLine(polylineCoordinates);
  }


  showTripAutoReloadReq(tripId,BuildContext context){
    Future.delayed( const Duration(seconds: AppConfig.reRequestTime),()async{
      var res = await TripRepository.tripDetails(tripId);
      if(res.trip?.status.toString()=="0"){
        if(context.mounted) {
          Dialogs.dynamicYesNo(
            yes: getLocal(context).try_again,
            no: getLocal(context).cancel,
            title:getLocal(context).please_try_again_or_cancel,
              context: context,
              content: getLocal(context)
                  .there_is_no_vehicle_at_this_time_please_try_again_after_few_minutes,
              noOnClick: () {
                TripRepository.tripCancel(tripId,"No Vehicle available.");
                SEORoute.goAndRemoveAll(context, MainPage());
              },
            yesOnClick: (){
              showTripAutoReloadReq(tripId, context);
                context.read<TripPayBloc>().add(OnRequestTripAgain(context));
            }
          );
        }
      }
    });
  }



}