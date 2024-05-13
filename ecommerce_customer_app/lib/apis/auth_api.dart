import 'package:flutter/cupertino.dart';
import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/middlewares/banned_user_middleware.dart';
import 'package:grostore/models/auth/login_response_model.dart';
import 'package:grostore/models/auth/registration_response_model.dart';
import 'package:grostore/models/auth/token_check_response.dart';
import 'package:grostore/models/common/user_info.dart';

class AuthApi{

static Future<LoginResponse> login(String requestBody,BuildContext context)async{
  var url = "${AppConfig.apiUrl}/login";
  Map<String,String> header = {
  "Accept": "application/json",
  "Content-Type": "application/json",
  "App-Language": app_language.$,
  };
    ApiResponse response = await ApiRequest.post(url:url, header:header,body: requestBody,middleWare:BannedMiddleware(context));
    debugPrint(response.body);
    if(response.result){
      return loginResponseFromJson(response.body);
    }else{
      return loginResponseDefaultValue();
    }
  }
static Future<TokenCheckResponse> tokenCheck(BuildContext context)async{
  var url = "${AppConfig.apiUrl}/token-check";
  Map<String,String> header = {
  "Accept": "application/json",
  "Content-Type": "application/json",
  "App-Language": app_language.$,
  "Authorization": "Bearer ${access_token.$}",
  };
  print(access_token.$);
    ApiResponse response = await ApiRequest.get(url, header,middleWare:BannedMiddleware(context));
    debugPrint(response.body);
    if(response.result){
      return tokenCheckResponseFromJson(response.body);
    }else{
      return TokenCheckResponse(result: false, user: UserInfo.init());
    }
  }

static Future<TokenCheckResponse> logout(BuildContext context)async{
  var url = "${AppConfig.apiUrl}/logout";
  Map<String,String> header = {
  "Accept": "application/json",
  "Content-Type": "application/json",
  "App-Language": app_language.$,
  "Authorization": "Bearer ${access_token.$}",
  };

    ApiResponse response = await ApiRequest.get(url, header,middleWare:BannedMiddleware(context));
    debugPrint(response.body);
    if(response.result){
      return tokenCheckResponseFromJson(response.body);
    }else{
      return TokenCheckResponse(result: false, user: UserInfo.init());
    }
  }

static Future<RegistrationResponse> registration(BuildContext context,String postBody)async{
  var url = "${AppConfig.apiUrl}/register";
  Map<String,String> header = {
  "Accept": "application/json",
  "Content-Type": "application/json",
  "App-Language": app_language.$
  };
    ApiResponse response = await ApiRequest.post(url:url, header:header,body: postBody,middleWare:BannedMiddleware(context));
    debugPrint(response.body);
    if(response.result){
      return registrationResponseFromJson(response.body);
    }else{
      return registrationResponseDefault();
    }
  }
static Future<RegistrationResponse> forgetPassword(BuildContext context,String postBody)async{
  var url = "${AppConfig.apiUrl}/forget-password";
  Map<String,String> header = {
  "Accept": "application/json",
  "Content-Type": "application/json",
  "App-Language": app_language.$
  };
    ApiResponse response = await ApiRequest.post(url:url, header:header, body: postBody,middleWare:BannedMiddleware(context));
    debugPrint(response.body);
    if(response.result){
      return registrationResponseFromJson(response.body);
    }else{
      return registrationResponseDefault();
    }
  }



}