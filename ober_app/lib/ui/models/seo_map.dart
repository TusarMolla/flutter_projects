import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/seo_typedef.dart';

class SeoMap extends StatelessWidget {
   SeoMap({super.key,required this.currentLocation,this.zoomScale=16,required this.initialLocation,required this.mapController, this.cameraMoveCompleted, this.polyline=const {},this.showPlacePicker = true,this.markers = const {}});
   LatLng currentLocation;
   LatLng initialLocation;
   double zoomScale;
   Completer<GoogleMapController> mapController;
   // OnMapCameraMove cameraMove;
   ArgumentCallback<CameraPosition?>? cameraMoveCompleted;
   CameraPosition? lastPosition ;
   bool isCameraMoveStarted = false;

   Map<PolylineId, Polyline> polyline ;
   Set<Marker> markers ;
   bool showPlacePicker ;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:CameraPosition(
              target:initialLocation,
              zoom: zoomScale,
            ),
            mapToolbarEnabled: true,
            onCameraMove:(CameraPosition position){
              lastPosition = position;
            },
            markers: markers,
            onCameraIdle: (){
              print("onCameraIdle");
              if(isCameraMoveStarted) {
                isCameraMoveStarted=false;
                if(cameraMoveCompleted !=null) {
                  cameraMoveCompleted!(lastPosition);
                }
              }
            },
            onCameraMoveStarted: (){
              isCameraMoveStarted = true;
              print("onCameraMoveStarted");
            },
            zoomControlsEnabled: false,
            polylines:Set<Polyline>.of(polyline.values) ,
            mapType: MapType.terrain,
            onMapCreated: (GoogleMapController controller) {

              if(!mapController.isCompleted){
                mapController.complete(controller);
              }
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,

          ),

          if(showPlacePicker)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 46.0),
              child: Image.asset(
                getAssetIcon("pin.png"),
                height: 46,
                width: 46,
                color: Colors.black,
              ),
            ),
          ),
          /*Positioned(
              bottom: 25,
              left: 60,
              right: 60,
              child: Buttons(
                padding: EdgeInsets.all(8),
                onPressed: ()async{
                },
                minHeight: 40.0,
                color: ThemeConfig.accentColor,
                child: Text(data.locationDetails,style: StyleConfig.fs14cWhite,),
              )),*/


        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: StyleConfig.buttonsRadius(40),
        onPressed: ()async{
        var tmp = await  mapController.future;
        // var cLocation = await getCurrentLocation;
        tmp.moveCamera(CameraUpdate.newLatLng(currentLocation));
        },
        child: const Icon(Icons.my_location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }




}
