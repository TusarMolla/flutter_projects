import 'dart:convert';

import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/cart_response.dart';
import 'package:grostore/models/response_model.dart';

class CartApi{
 static Future<ResponseModel<CartResponse>> carts()async{
    var url = "${AppConfig.apiUrl}/carts";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCurrencyHeader());
    print(header);
    ApiResponse response = await ApiRequest.get(url, header);
    print(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,cartResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,CartResponse(result: false, message: '', carts: [], cartCount: 0, subTotal: '0.0', total: '0.0', couponDiscount: ''));
    }
  }

 static Future<ResponseModel<CartResponse>> addToCart({required variantId,required int qty})async{
    var url = "${AppConfig.apiUrl}/carts/add";
    Map<String,String> header = getCommonHeader();
    header.addAll(getCurrencyHeader());
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    var postBody = jsonEncode({
      "product_variation_id":variantId,
      "quantity":qty
    });

    ApiResponse response = await ApiRequest.post(body: postBody, url: url,header: header);
    if(response.result){
      return ResponseModel(response.statusCode,cartResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode, CartResponse(result: false, message: '', carts: [], cartCount: 0, subTotal: '0.0', total: '0.0', couponDiscount: ''));
    }
  }

  static Future<ResponseModel<CartResponse>> couponApply({required code})async{
    var url = "${AppConfig.apiUrl}/coupons/coupon-apply";
    Map<String,String> header = getCommonHeader();
    header.addAll(getCurrencyHeader());
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    var postBody = jsonEncode({
        "code":"$code"
    });

    ApiResponse response = await ApiRequest.post(body: postBody, url: url,header: header);
    if(response.result){
      return ResponseModel(response.statusCode,cartResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,CartResponse(result: false, message: '', carts: [], cartCount: 0, subTotal: '0.0', total: '0.0', couponDiscount: ''));
    }
  }
 static Future<ResponseModel<CartResponse>> cartUpdate({required id,required String action})async{
    var url = "${AppConfig.apiUrl}/carts/update";
    Map<String,String> header = getCommonHeader();
    header.addAll(getCurrencyHeader());
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    var postBody = jsonEncode({
      "id":id,
      "action":action
    });

    ApiResponse response = await ApiRequest.post(body: postBody, url: url,header: header);
    if(response.result){
      return ResponseModel(response.statusCode,cartResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,CartResponse(result: false, message: '', carts: [], cartCount: 0, subTotal: '0.0', total: '0.0', couponDiscount: ''));
    }
  }

}