import 'dart:convert';
import 'dart:io';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/cart_response.dart';
import 'package:grostore/models/order/order_summery_response.dart';
import 'package:grostore/models/response_model.dart';
import 'package:grostore/models/user/addresses_response.dart';

import '../models/common_response.dart';

class UserApi{
 static Future<AddressesResponse> getAddresses()async{
    var url = "${AppConfig.apiUrl}/address";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });

    ApiResponse response = await ApiRequest.get(url, header);
    if(response.result){
      return addressesResponseFromJson(response.body);
    }else{
      return AddressesResponse(data: []);
    }
  }

 static Future<ResponseModel<CommonResponse>> updateProfile({File? file,String? name,String? phone})async{
    var url = "${AppConfig.apiUrl}/customer-profile/update";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    print(header);
    Map<String, String>? body;
    if(name !=null && phone !=null) {
       body = {"name": name, "phone": phone};
    }
    ApiResponse response = await ApiRequest.fileReq(url: url,header:  header,body: body,file: file);


    if(response.result){
      return ResponseModel(200,commonResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,commonResponseFromJson(response.body));
    }
  }

 static Future<ResponseModel<CommonResponse>> updatePassword(body)async{
   var url = "${AppConfig.apiUrl}/customer-profile/change-password";
   Map<String,String> header = getCommonHeader();
   header.addAll({
     "Authorization":"Bearer ${access_token.$}"
   });
   ApiResponse response = await ApiRequest.post(url:  url,header:  header,body: body);

   print(response.body);
   if(response.result){
     return ResponseModel(200,commonResponseFromJson(response.body));
   }else{
     return ResponseModel(response.statusCode,commonResponseFromJson(response.body));
   }
 }

}