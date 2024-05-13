import 'dart:convert';

import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/cart_response.dart';
import 'package:grostore/models/common_response.dart';
import 'package:grostore/models/country_response.dart';
import 'package:grostore/models/edit_address_response.dart';
import 'package:grostore/models/order/order_summery_response.dart';
import 'package:grostore/models/response_model.dart';
import 'package:grostore/models/state_response.dart';
import 'package:grostore/models/user/addresses_response.dart';

import '../models/city_response.dart';

class AddressApi{

  static Future<ResponseModel<CommonResponse>> addAddress({required int countryId,required int stateId,required int cityId,required int isDefault,required String address})
  async{
    var url = "${AppConfig.apiUrl}/address/store";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    var postBody = jsonEncode({
      "country_id":countryId,
      "state_id":stateId,
      "city_id":cityId,
      "is_default":isDefault,
      "address":address
    });

    ApiResponse response = await ApiRequest.post(body: postBody, url: url,header: header);
    if(response.result){
      return ResponseModel(response.statusCode,commonResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode, CommonResponse(result: false, message: 'Failed'));
    }
  }


  static Future<ResponseModel<CommonResponse>> updateAddress({required int id,required int countryId,required int stateId,required int cityId,required int isDefault,required String address})
  async{
    var url = "${AppConfig.apiUrl}/address/update";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    var postBody = jsonEncode({
      "id":id,
      "country_id":countryId,
      "state_id":stateId,
      "city_id":cityId,
      "is_default":isDefault,
      "address":address
    });

    ApiResponse response = await ApiRequest.post(body: postBody, url: url,header: header);
    if(response.result){
      return ResponseModel(response.statusCode,commonResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode, CommonResponse(result: false, message: 'Failed'));
    }
  }

  static Future<ResponseModel<CommonResponse>> deleteAddress({required int id})
  async{
    var url = "${AppConfig.apiUrl}/address/delete/$id";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });

    ApiResponse response = await ApiRequest.get( url, header);
    if(response.result){
      return ResponseModel(response.statusCode,commonResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode, CommonResponse(result: false, message: 'Failed'));
    }
  }


  static Future<ResponseModel<AddressesResponse>> getAddresses()async{
    var url = "${AppConfig.apiUrl}/address";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });

    ApiResponse response = await ApiRequest.get(url, header);
    if(response.result){
      return ResponseModel(response.statusCode,addressesResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,AddressesResponse(data: []));
    }
  }

  static Future<ResponseModel<EditAddressResponse>> editAddresses(id)async{
    var url = "${AppConfig.apiUrl}/address/edit/$id";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    print(url.toString());
    ApiResponse response = await ApiRequest.get(url, header);
    if(response.result){
      return ResponseModel(response.statusCode,editAddressResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,EditAddressResponse(data: Data.fromJson({}), result: false, status: 500));
    }
  }

 static Future<ResponseModel<CountryResponse>> getCountries()async{
    var url = "${AppConfig.apiUrl}/address/countries";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });

    ApiResponse response = await ApiRequest.get(url, header);
    print(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,countryResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,CountryResponse(data: []));
    }
  }

 static Future<ResponseModel<StateResponse>> getState(id)async{
    var url = "${AppConfig.apiUrl}/address/states?country_id=$id";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });

    ApiResponse response = await ApiRequest.get(url, header);
    if(response.result){
      return ResponseModel(response.statusCode,stateResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,StateResponse(data: []));
    }
  }

 static Future<ResponseModel<CityResponse>> getCity(id)async{
    var url = "${AppConfig.apiUrl}/address/cities?state_id=$id";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });

    ApiResponse response = await ApiRequest.get(url, header);
    if(response.result){
      return ResponseModel(response.statusCode,cityResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,CityResponse(data: []));
    }
  }

}