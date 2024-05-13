import 'package:flutter/material.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/home_banner_response.dart';
import 'package:grostore/models/response_model.dart';


class BannersApi{
  static Future<ResponseModel<HomeBannerResponse>> homeBanner(BuildContext context)async{
    var url = "${AppConfig.apiUrl}/banner/home";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    ApiResponse response = await ApiRequest.get(url, header);
    debugPrint(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,homeBannerResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,HomeBannerResponse(data: []));
    }
  }

}