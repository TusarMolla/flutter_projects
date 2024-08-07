

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/models/auto_complete_response.dart';
import 'package:ober_app/models/directions_response.dart';
import 'package:ober_app/models/geo_coding_response.dart';
import 'package:ober_app/models/google_map_api_distance_matrix_response.dart';
import 'package:ober_app/models/location_details_response.dart';
import 'package:ober_app/others/api_request.dart';

class MapRepository{

 static Future<GeocodingResponse> formattedAddress (LatLng latLng)async{
     var response = await ApiRequest.get(url: "${AppConfig.googleMapApiUrl}/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&result_type=neighborhood|political&key=${AppConfig.googleMapAPIKey}");

     return geocodingResponseFromJson(response.body);

  }

 static Future<DirectionsResponse> directions ({required LatLng start,required LatLng end})async{
   var tmpStart = "${start.latitude}, ${start.longitude}";
   var tmpEnd = "${end.latitude}, ${end.longitude}";
     var response = await ApiRequest.get(url: "${AppConfig.googleMapApiUrl}/directions/json?origin=$tmpStart&destination=$tmpEnd&key=${AppConfig.googleMapAPIKey}&mode=driving&transit_mode=bus");
     return directionsResponseFromJson(response.body);
  }

  static Future<AutoCompleteResponse> search(String location)async{
    var response = await ApiRequest.get(url: "${AppConfig.googleMapApiUrl}/place/autocomplete/json?input=$location&key=${AppConfig.googleMapAPIKey}");
    return autoCompleteResponseFromJson(response.body);
}
  static Future<LocationDetailsResponse> placeDetails(String locationId)async{
    var response = await ApiRequest.get(url: "${AppConfig.googleMapApiUrl}/place/details/json?fields=name%2Crating%2Cgeometry&place_id=$locationId&key=${AppConfig.googleMapAPIKey}");
    return locationDetailsResponseFromJson(response.body);
}

 static Future<GoogleMapDistanceMatrixResponse>  placeDistance({required startLocation ,required endLocation,String units="metric",mode="car"})async{
    var url = "${AppConfig.googleMapApiUrl}/distancematrix/json?destinations=$endLocation&origins=$startLocation&units=$units&key=${AppConfig.googleMapAPIKey}";
    var response = await ApiRequest.get(url:url);
    return googleMapDistanceMatrixResponseFromJson(response.body);
  }


}