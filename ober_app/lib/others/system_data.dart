

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/models/rating_response.dart';
import 'package:ober_app/models/user_info_response.dart';

class SystemData{
 static User? userData ;
 static bool isLogedIn=false;
 // static LatLng? currentLocation ;
 static LatLng? userCurrentLocation ;
 static RatingResponse? userRating;
 static double perKiloRate = 16.0;

}