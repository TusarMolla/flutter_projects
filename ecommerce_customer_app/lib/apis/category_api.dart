import 'package:flutter/material.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/response_model.dart';
import 'package:grostore/models/category_response.dart';

class CategoryApi{
  static Future<ResponseModel<CategoryResponse>> topCategory()async{
    var url = "${AppConfig.apiUrl}/category/top-category";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    ApiResponse response = await ApiRequest.get(url, header);

    if(response.result){
      return ResponseModel(response.statusCode,categoryResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,categoryResponseFromJson(""));
    }

  }
  static Future<ResponseModel<CategoryResponse>> getCategories(page)async{
    var url = "${AppConfig.apiUrl}/category/all?page=$page";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    print(url);
    ApiResponse response = await ApiRequest.get(url, header);

    if(response.result){
      return ResponseModel(response.statusCode,categoryResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,categoryResponseFromJson(""));
    }

  }
}