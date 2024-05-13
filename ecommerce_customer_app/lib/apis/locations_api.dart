import 'package:flutter/material.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/home_banner_response.dart';
import 'package:grostore/models/locations_response.dart';
import 'package:grostore/models/response_model.dart';


class LocationApi{
  static Future<ResponseModel<LocationsResponse>> getLocations(BuildContext context)async{
    var url = "${AppConfig.apiUrl}/locations";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    ApiResponse response = await ApiRequest.get(url, header);

    if(response.result){
      return ResponseModel(response.statusCode,locationsResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode, LocationsResponse(data: []));
    }
  }

}