import 'dart:convert';

import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/cart_response.dart';
import 'package:grostore/models/logistics_response.dart';
import 'package:grostore/models/order/order_details_response.dart';
import 'package:grostore/models/order/track_order_response.dart';
import 'package:grostore/models/response_model.dart';
import 'package:grostore/models/order/order_summery_response.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/models/order_create_response.dart';
import 'package:grostore/models/payment_types_response.dart';
import 'package:grostore/models/time_slote_response.dart';

class OrderApi{
 static Future<ResponseModel<OrdersResponse>> getOrders(key,page)async{
    var url = "${AppConfig.apiUrl}/customer-order-history?status=$key&page=$page";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCurrencyHeader());

    ApiResponse response = await ApiRequest.get(url, header);

    if(response.result){
      return ResponseModel(response.statusCode,ordersResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,OrdersResponse.init());
    }
  }

 static Future<ResponseModel<OrderDetailsResponse>> getDetails({required code})async{
    var url = "${AppConfig.apiUrl}/order/invoice/$code";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(url, header);

    if(response.result){
      return ResponseModel(response.statusCode,orderDetailsResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,orderDetailsResponseFromJson(""));
    }
  }

 static Future<ResponseModel<OrderSummeryResponse>> getSummery({required logistic_zone_id})async{
    var url = "${AppConfig.apiUrl}/order/summery";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCurrencyHeader());
    header.addAll(getCouponHeader());

   var postBody = jsonEncode({
      "logistic_zone_id":logistic_zone_id
    });
    ApiResponse response = await ApiRequest.post(url:url, header:header,body: postBody);
print(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,orderSummeryResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,OrderSummeryResponse(subTotal: "", tax: "", shippingCharge: "", isFreeShipping:false, couponDiscount: "", total: ""));
    }
  }

 static Future<ResponseModel<LogisticsResponse>> getLogistics({required cityId})async{
    var url = "${AppConfig.apiUrl}/logistic-by-city";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
   var postBody = jsonEncode({
     "city_id":cityId
   });
    ApiResponse response = await ApiRequest.post(url:url, header:header,body: postBody);
print(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,logisticsResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,LogisticsResponse(data: []));
    }
  }

 static Future<ResponseModel<OrderCreateResponse>> createOrder({required shippingId,
   required billingId,
   required phone,
   required alternativePhone,
   required logisticZoneId,
   required tips,
   required shippingDeliveryType,
   required timeslot,
   required scheduledData
 })async{
    var url = "${AppConfig.apiUrl}/order/store";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCouponHeader());
    header.addAll(getCurrencyHeader());

   var postBody = jsonEncode({
       "shipping_address_id":shippingId,
       "billing_address_id":billingId,
       "phone":phone,
       "alternative_phone":alternativePhone,
       "chosen_logistic_zone_id":logisticZoneId,
       "tips":tips,
       "shipping_delivery_type":shippingDeliveryType,
       "timeslot":timeslot,
       "scheduled_date":scheduledData,

   });

    ApiResponse response = await ApiRequest.post(url:url, header:header,body: postBody);

    if(response.result){
      return ResponseModel(response.statusCode,orderCreateResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,OrderCreateResponse.init());
    }
  }

 static Future<ResponseModel<OrderCreateResponse>> createOrderByCOD({required shippingId,
   required billingId,
   required phone,
   required alternativePhone,
   required logisticZoneId,
   required tips,
   required shippingDeliveryType,
   required timeslot,
   required scheduledData
 })async{
    var url = "${AppConfig.apiUrl}/order/cod";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCouponHeader());
    header.addAll(getCurrencyHeader());
   var postBody = jsonEncode({
       "shipping_address_id":shippingId,
       "billing_address_id":billingId,
       "phone":phone,
       "alternative_phone":alternativePhone,
       "chosen_logistic_zone_id":logisticZoneId,
       "tips":tips,
       "shipping_delivery_type":shippingDeliveryType,
       "timeslot":timeslot,
       "scheduled_date":scheduledData,

   });
    ApiResponse response = await ApiRequest.post(url:url, header:header,body: postBody);
print(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,orderCreateResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,OrderCreateResponse.init());
    }
  }

 static Future<ResponseModel<OrderCreateResponse>> createOrderByWallet({required shippingId,
   required billingId,
   required phone,
   required alternativePhone,
   required logisticZoneId,
   required tips,
   required shippingDeliveryType,
   required timeslot,
   required scheduledData
 })async{
    var url = "${AppConfig.apiUrl}/order/wallet";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCouponHeader());
    header.addAll(getCurrencyHeader());
   var postBody = jsonEncode({
       "shipping_address_id":shippingId,
       "billing_address_id":billingId,
       "phone":phone,
       "alternative_phone":alternativePhone,
       "chosen_logistic_zone_id":logisticZoneId,
       "tips":tips,
       "shipping_delivery_type":shippingDeliveryType,
       "timeslot":timeslot,
       "scheduled_date":scheduledData,

   });
    ApiResponse response = await ApiRequest.post(url:url, header:header,body: postBody);
print(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,orderCreateResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,OrderCreateResponse.init());
    }
  }

 static Future<ResponseModel<TimeSlotResponse>> getTimeSlot()async{
    var url = "${AppConfig.apiUrl}/time-slot";
    Map<String,String> header = getCommonHeader();
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(  url, header);
    if(response.result){
      return ResponseModel(response.statusCode,timeSlotResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,TimeSlotResponse(days: "0",timeSlots: []));
    }
  }

 static Future<ResponseModel<List<PaymentTypesResponse>>> getPaymentTypes()async{
    var url = "${AppConfig.apiUrl}/payment-types";
    Map<String,String> header = getCommonHeader();
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(  url, header);
    if(response.result){
      return ResponseModel(response.statusCode,paymentTypesResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,[]);
    }
  }

  static Future<ResponseModel<TrackOrderResponse>> trackOrder(id)async{
    var url = "${AppConfig.apiUrl}/order/track-order?code=$id";
    Map<String,String> header = getCommonHeader();
    header.addAll({
      "Authorization":"Bearer ${access_token.$}"
    });
    header.addAll(getCurrencyHeader());
    ApiResponse response = await ApiRequest.get(  url, header);
    print(response.body);
    if(response.result){
      return ResponseModel(response.statusCode,trackOrderResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,trackOrderResponseFromJson(''));
    }
  }



}