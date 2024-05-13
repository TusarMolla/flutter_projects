import 'package:flutter/material.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/coupon_response.dart';
import 'package:grostore/models/home_banner_response.dart';
import 'package:grostore/models/response_model.dart';


class CouponsApi{
  static Future<ResponseModel<CouponResponse>> getCoupons()async{
    var url = "${AppConfig.apiUrl}/coupons";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(url, header);
    debugPrint(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,couponResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,CouponResponse(data: []));
    }
  }

}