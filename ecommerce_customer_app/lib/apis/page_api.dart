

import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/models/page_response.dart';
import 'package:grostore/models/response_model.dart';

class PageApi{

  static Future<ResponseModel<PageResponse>> getPage({required String slug})
  async{
    var url = "${AppConfig.apiUrl}/pages/$slug";
    Map<String,String> header = getCommonHeader();


    ApiResponse response = await ApiRequest.get( url, header);
    if(response.result){
      return ResponseModel(response.statusCode,pageResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode, pageResponseFromJson(""));
    }
  }



}