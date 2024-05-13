import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/language_response.dart';
import 'package:grostore/models/response_model.dart';

class LanguageApi{
  static Future<ResponseModel<LanguageResponse>> getLanguages()async{
    var url = "${AppConfig.apiUrl}/languages";
    Map<String,String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$
    };
    ApiResponse response = await ApiRequest.get(url, header);
    if(response.statusCode== 200 && response.result){
      return ResponseModel(response.statusCode,languageResponseFromJson(response.body));
    }else{
      return ResponseModel(response.statusCode,languageResponseFromJson(""));
    }
  }

}