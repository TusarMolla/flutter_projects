import 'dart:io';

import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/models/common_response.dart';
import 'package:ober_app/models/ticket_detail_response.dart';
import 'package:ober_app/models/ticket_list_response.dart';
import 'package:ober_app/others/api_request.dart';

class TicketRepository{
  static Future<CommonResponse> createNewTicket({required Map<String, String> postBody,required String fileKey,File? file})async{
    var response =await ApiRequest.fileReq(url: "${AppConfig.apiUrl}/support-ticket",header: getAuthHeader,fileKey: fileKey,file: file,body: postBody);
    print(response.body);
    return commonResponseFromJson(response.body);
  }
  static Future<CommonResponse> replyTicket({required id,required Map<String, String> postBody,required String fileKey,File? file})async{
    postBody.addAll({
      "ticket_id":id.toString()
    });
    var response =await ApiRequest.fileReq(url: "${AppConfig.apiUrl}/support-ticket-reply",header: getAuthHeader,fileKey: fileKey,file: file,body: postBody);
    print(response.body);
    return commonResponseFromJson(response.body);
  }
   static Future<TicketListResponse> getTicketList(int? page)async{
    var response =await ApiRequest.get(url: "${AppConfig.apiUrl}/support-ticket-list?page=$page",header: getAuthHeader);
    return ticketListResponseFromJson(response.body);
  }

   static Future<TicketDetailResponse> getTicketDetails(int? id)async{
    var response =await ApiRequest.get(url: "${AppConfig.apiUrl}/support-ticket-details/$id",header: getAuthHeader);
    return ticketDetailResponseFromJson(response.body);
  }

   static Future<CommonResponse> deleteTicket(int id)async{
    var response =await ApiRequest.get(url: "${AppConfig.apiUrl}/tickets/ticket-close/$id",header: getAuthHeader);
    return commonResponseFromJson(response.body);
  }


}