import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/response_model.dart';
import 'package:grostore/models/product_details_response.dart';
import 'package:grostore/models/product_mini_response.dart';

class ProductApi {
  static Future<ResponseModel<ProductMiniResponse>> getAllProducts({
    String? categoryId='',min_price='',max_price='',search='',page=1
  }) async {
    var url = "${AppConfig.apiUrl}/products?page=$page&search=$search&min_price=$min_price&max_price=$max_price&category_id=$categoryId";
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$,
      "Stock-Location-Id": stock_location_id.$
    };
    print(url);
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(url, header);
    if (response.result) {
      return ResponseModel(
          response.statusCode, productMiniResponseFromJson(response.body));
    } else {
      return ResponseModel(response.statusCode, ProductMiniResponse(data: []));
    }
  }

  static Future<ResponseModel<ProductMiniResponse>> bestSelling(
      BuildContext context) async {
    var url = "${AppConfig.apiUrl}/products/best-selling";
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$,
      "Stock-Location-Id": stock_location_id.$
    };
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(url, header);
    if (response.result) {
      return ResponseModel(
          response.statusCode, productMiniResponseFromJson(response.body));
    } else {
      return ResponseModel(response.statusCode, ProductMiniResponse(data: []));
    }
  }

  static Future<ResponseModel<ProductMiniResponse>> relatedProducts(
      BuildContext context, String slug) async {
    var url = "${AppConfig.apiUrl}/products/related";
    var postBody = jsonEncode({"slug": slug});
    print(postBody);
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    header.addAll(getCurrencyHeader());
    ApiResponse response =
        await ApiRequest.post(url: url, header: header, body: postBody);
    if (response.result) {
      return ResponseModel(
          response.statusCode, productMiniResponseFromJson(response.body));
    } else {
      return ResponseModel(response.statusCode, ProductMiniResponse(data: []));
    }
  }

  static Future<ResponseModel<ProductDetailsResponse>> details(
      BuildContext context, String slug) async {
    var url = "${AppConfig.apiUrl}/products/$slug";
    Map<String, String> header = getCommonHeader();
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(url, header);
    print(response.body);
    if (response.result) {
      return ResponseModel(
          response.statusCode, productDetailsResponseFromJson(response.body));
    } else {
      return ResponseModel(
          response.statusCode,
          ProductDetailsResponse(
              result: false, data: ProductDetailsInfo.init(), status: 400));
    }
  }
}
