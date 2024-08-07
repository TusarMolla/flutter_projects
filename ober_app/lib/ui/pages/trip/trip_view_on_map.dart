import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/blocs/trip_bloc.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/states/trip_state.dart';
import 'package:ober_app/ui/models/seo_map.dart';
import 'package:ober_app/ui/models/seo_web_view.dart';
import 'package:url_launcher/url_launcher.dart';

class TripViewOnMap extends StatelessWidget {
  TripViewOnMap({super.key,required this.startLatLng});
  final LatLng startLatLng;


  @override
  Widget build(BuildContext context) {



    return BlocBuilder<TripBloc,TripState>(
        builder: (context,state) {
          return Scaffold(
            body: Stack(
              children: [
                SeoMap(currentLocation: SystemData.userCurrentLocation!, initialLocation: startLatLng, mapController: state.controller,polyline: state.polyline,showPlacePicker: false,
                markers: state.markers,
                ),
                Positioned(

                    bottom: 80,
                    child: Buttons.round(onPress: ()async{

                      // String iosUrl = 'https://maps.apple.com/?q=$latitude,$longitude';

                      // String googleUrl ='https://www.google.com/maps/dir/?api=1&origin=${state.startLatLng!.latitude}, ${state.startLatLng!.longitude}&destination=${state.endLatLng!.latitude}, ${state.endLatLng!.longitude}&dir_action=navigate';
                      // SEORoute.go(context, SeoWebView(uri: Uri.parse(googleUrl)));

                      if (Platform.isAndroid) {
                        String googleUrl ='https://www.google.com/maps/dir/?api=1&origin=${state.startLatLng!.latitude}, ${state.startLatLng!.longitude}&destination=${state.endLatLng!.latitude}, ${state.endLatLng!.longitude}&dir_action=navigate';
                        if (await canLaunchUrl(Uri.parse(googleUrl))) {
                      await launchUrl(Uri.parse(googleUrl),mode:LaunchMode.inAppBrowserView );
                      } else {
                      throw 'Could not launch $googleUrl';
                      }
                      }
                    }, child: Text("View Driving Mode")))
              ],
            ),
          );
        }
    );
  }
}
