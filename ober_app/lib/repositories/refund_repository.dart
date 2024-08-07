

import 'dart:convert';

import 'package:ober_app/events/refund_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/models/common_response.dart';
import 'package:ober_app/models/refund_response.dart';
import 'package:ober_app/others/api_request.dart';

class RefundRepository {
 static Future<RefundResponse> initData({page = 1})async{
    var response = await ApiRequest.get(url: getApiPath("refund-request?page=$page"),header: getAuthHeader);

    return refundResponseFromJson(response.body);
    
  }
  
  static Future<CommonResponse> requestRefund({required RefundRequest event})async{
   var body = jsonEncode({
     "trip_id":event.id,
     "bank_name":event.bankName,
     "account_holder_name":event.holderName,
     "account_number":event.accountNo,
     "branch_name":event.bankName,
     "phone_number":event.phoneNo,
   });
    var response = await ApiRequest.post(url: getApiPath("make-refund-request"),header: getAuthHeader,body: body);

    return commonResponseFromJson(response.body);

  }


  
}