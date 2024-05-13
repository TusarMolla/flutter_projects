import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/common_response.dart';
import 'package:grostore/models/coupon_response.dart';
import 'package:grostore/models/home_banner_response.dart';
import 'package:grostore/models/refund_response.dart';
import 'package:grostore/models/response_model.dart';
import 'package:grostore/models/wallet_history_response.dart';


class RefundApi{
  static Future<ResponseModel<RefundResponse>> getRefundHistory(page)async{
    var url = "${AppConfig.apiUrl}/refunds?page=$page";
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
    if(response.statusCode== 200 && response.result){
      return ResponseModel(response.statusCode,refundResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,refundResponseFromJson(""));
    }
  }

  static Future<ResponseModel<CommonResponse>> refundRequest(order_item_id,reason)async{
    var url = "${AppConfig.apiUrl}/refund/request";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });

    var postBody = jsonEncode({
      "order_item_id":order_item_id,
      "refund_reason":reason
    });



    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.post(url:url, body: postBody,header:header);
    debugPrint(response.body);
    if(response.statusCode== 200 && response.result){
      return ResponseModel(response.statusCode,commonResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,commonResponseFromJson(""));
    }
  }

}