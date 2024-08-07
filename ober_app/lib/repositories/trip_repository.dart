import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/main.dart';
import 'package:ober_app/models/common_response.dart';
import 'package:ober_app/models/trip_detail_response.dart';
import 'package:ober_app/models/trip_list_response.dart';
import 'package:ober_app/models/trip_request_response.dart';
import 'package:ober_app/models/trip_status_response.dart';
import 'package:ober_app/others/api_request.dart';

class TripRepository{

  static Future<TripListResponse> tripList(status)async{
    var response = await ApiRequest.get(url: getApiPath("trip/list?status=$status"),header: getAuthHeader);
    return tripListResponseFromJson(response.body);
  }

  static Future<TripDetailsResponse> tripDetails(id)async{

    var response = await ApiRequest.get(url: getApiPath("trip-details/$id"),header: getAuthHeader);
    return tripDetailsResponseFromJson(response.body);
  }

  static Future<TripStatusResponse> checkStatus()async{
    var response = await ApiRequest.get(url: getApiPath("check-driver-passenger-available-status"),header: getAuthHeader);
    print("trip status ${response.body}");
    return tripStatusResponseFromJson(response.body);
  }

  static Future<CommonResponse> tripCancel(id,reason)async{
    var body = jsonEncode({
      "trip_id":id,
      "reason":reason
    });
    var response = await ApiRequest.post(url: getApiPath("cancel-ride"),header: getAuthHeader,body: body);
    return commonResponseFromJson(response.body);
  }


  static Future<TripRequestResponse> requestVehicleCategory(Map<String,dynamic>body)async{
    // print("BODY ${body}");
    var tmp = jsonEncode(body);
    var res = await ApiRequest.post(url: getApiPath("create-trip"), body: tmp,header: getAuthHeader);
print("VehicleCategory ${res.body}");
    return tripRequestResponseFromJson(res.body);


  }
  static Future<CommonResponse> requestATrip(Map<String,dynamic>body)async{
    var tmp = jsonEncode(body);

    var res = await ApiRequest.post(url: getApiPath("get-available-vehicles"), body: tmp,header: getAuthHeader);
    debugPrint("rrr ${res.body}");
    return commonResponseFromJson(res.body);
  }

  static Future<CommonResponse> tripRating(var tripId,double rating,String comment)async{
    var body = jsonEncode({
      "trip_id":tripId,
      "passenger_rating":rating,
      "passenger_comment":comment
    });

    var res = await ApiRequest.post(url: getApiPath("passenger-rating-submit"), body: body,header: getAuthHeader);
    // print(res.body);
    var d =  commonResponseFromJson(res.body);
    SEOToast.show(globalState.currentState!.context, d.message);
    return d;
  }

  static Future<CommonResponse> tripComplain(var tripId,String title,String message,{File? img})async{
    var body =<String,String> {
      "trip_id":tripId.toString(),
      "title":title,
      "description":message,
    };
    var res = await ApiRequest.fileReq(url: getApiPath("make-complain"), body: body,header: getAuthHeader,fileKey: "image",file: img);
    // print(res.body);
    return commonResponseFromJson(res.body);
  }

  static Future<CommonResponse> tripPay(var tripId,double amount,String cardNumber,String cvc,String expDate,String cardHolderName)async{
    var body = jsonEncode({
      "transaction_amount":amount,
      "trip_id":tripId,
      "card_number":cardNumber,
      "cvc":cvc,
      "exp_date":expDate,
      "acount_holder_name":cardHolderName ,
    });

    var res = await ApiRequest.post(url: getApiPath("store-payment-info"), body: body,header: getAuthHeader);
    // print(res.body);
    return commonResponseFromJson(res.body);
  }


}