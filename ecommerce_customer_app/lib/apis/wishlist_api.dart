import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/common_response.dart';
import 'package:grostore/models/response_model.dart';
import 'package:grostore/models/product_details_response.dart';
import 'package:grostore/models/product_mini_response.dart';
import 'package:grostore/models/wishlist_response.dart';

class WishlistApi {
  static Future<ResponseModel<WishlistResponse>> getWishlist() async {
    var url = "${AppConfig.apiUrl}/wishlist";
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$,
      "Stock-Location-Id": stock_location_id.$
    };
    header.addAll({"Authorization": "Bearer ${access_token.$}"});
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(url, header);
    if (response.result) {
      return ResponseModel(
          response.statusCode, wishlistResponseFromJson(response.body));
    } else {
      return ResponseModel(response.statusCode, WishlistResponse(data: []));
    }
  }

  static Future<ResponseModel<CommonResponse>> checkWishlist(id) async {
    var url = "${AppConfig.apiUrl}/wishlist/check/$id";
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$,
      "Stock-Location-Id": stock_location_id.$
    };

    header.addAll({"Authorization": "Bearer ${access_token.$}"});
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(url, header);
    if (response.result) {
      return ResponseModel(
          response.statusCode, commonResponseFromJson(response.body));
    } else {
      return ResponseModel(
          response.statusCode, CommonResponse(result: false, message: ""));
    }
  }

  static Future<ResponseModel<CommonResponse>> deleteWishlist(id) async {
    var url = "${AppConfig.apiUrl}/delete-wishlist/$id";
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$,
      "Stock-Location-Id": stock_location_id.$
    };

    header.addAll({"Authorization": "Bearer ${access_token.$}"});
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(url, header);
    if (response.result) {
      return ResponseModel(
          response.statusCode, commonResponseFromJson(response.body));
    } else {
      return ResponseModel(
          response.statusCode, CommonResponse(result: false, message: ""));
    }
  }

  static Future<ResponseModel<CommonResponse>> addWishlist(id) async {
    var url = "${AppConfig.apiUrl}/add-to-wishlist";
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$,
      "Stock-Location-Id": stock_location_id.$
    };
    header.addAll({"Authorization": "Bearer ${access_token.$}"});
    header.addAll(getCurrencyHeader());

    var postBody = jsonEncode({"product_id": id});
    ApiResponse response =
        await ApiRequest.post(body: postBody, url: url, header: header);
    if (response.result) {
      return ResponseModel(
          response.statusCode, commonResponseFromJson(response.body));
    } else {
      return ResponseModel(
          response.statusCode, CommonResponse(result: false, message: ""));
    }
  }
}
