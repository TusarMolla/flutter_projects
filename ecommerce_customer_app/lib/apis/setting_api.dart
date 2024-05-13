import 'package:flutter/material.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/coupon_response.dart';
import 'package:grostore/models/help_center_response.dart';
import 'package:grostore/models/home_banner_response.dart';
import 'package:grostore/models/refund_response.dart';
import 'package:grostore/models/response_model.dart';
import 'package:grostore/models/setting_response.dart';
import 'package:grostore/models/wallet_history_response.dart';


class SettingApi{
  static Future<ResponseModel<SettingResponse>> getSettings()async{
    var url = "${AppConfig.apiUrl}/settings";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    ApiResponse response = await ApiRequest.get(url, header);
    if(response.statusCode== 200 && response.result){
      return ResponseModel(response.statusCode,settingResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,settingResponseFromJson(""));
    }
  }

  static Future<ResponseModel<HelpCenterResponse>> getHelpCenter()async{
    var url = "${AppConfig.apiUrl}/settings/help-center";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    ApiResponse response = await ApiRequest.get(url, header);
    if(response.statusCode== 200 && response.result){
      return ResponseModel(response.statusCode,helpCenterResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,helpCenterResponseFromJson(""));
    }
  }

}