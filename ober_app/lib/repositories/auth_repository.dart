import 'dart:convert';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/models/common_response.dart';
import 'package:ober_app/models/user_info_response.dart';
import 'package:ober_app/others/api_request.dart';

class AuthRepository{
  static Future<UserInfoResponse> getInfo()async{
    var url = "${AppConfig.apiUrl}/user-details";

    var res = await ApiRequest.get(url: url,header: getAuthHeader);

    return userInfoResponseFromJson(res.body);

  }
  static Future<CommonResponse> updatePassword(String old,String newPass,String conPass)async{
    var url = "${AppConfig.apiUrl}/user-password-update";
    var body = jsonEncode({
      "current_password":old,
      "password":newPass,
      "password_confirmation":conPass
    });
    var res = await ApiRequest.put(url: url, body: body,header: getAuthHeader);

    return commonResponseFromJson(res.body);

  }

  static Future<CommonResponse> logout()async{
    var url = "${AppConfig.apiUrl}/logout";
    var res = await ApiRequest.post(url: url,header: getAuthHeader,body: "");
    return commonResponseFromJson(res.body);
  }

  static Future<CommonResponse> onLogin(String userNameOrEmail,String password)async{
    var url = "${AppConfig.apiUrl}/login";
    var body = jsonEncode({
      "login":userNameOrEmail,
      "password":password,
      "role":"passenger"
    });
    print(body);
    var res = await ApiRequest.post(url: url, body: body);

    return commonResponseFromJson(res.body);
  }
  static Future<CommonResponse> onSignUp(
      {
       required String userName,
        required String email,
        required String password,
        required String confirmPassword})async{
    var url = "${AppConfig.apiUrl}/registration";
    var body = jsonEncode({
    "username":userName,
    "email":email,
    "password":password,
    "confirm_password":password,
    "role":"passenger"
    });

    var res = await ApiRequest.post(url: url, body: body);
    print(res.body);
    return commonResponseFromJson(res.body);
  }

  static Future<CommonResponse> resetPassword(
      {
        required String otp,
        required String email,
        required String password,
        required String confirmPassword})async{
    var url = "${AppConfig.apiUrl}/password/reset";
    var body = jsonEncode({
      "otp_code":otp,
      "email":email,
      "password":password,
      "password_confirmation":confirmPassword,
    });
    var res = await ApiRequest.post(url: url, body: body);
    // print(url);
    // print(res.body);
    return commonResponseFromJson(res.body);
  }


  static Future<CommonResponse> forgotReq(
      {required String email})async{
    var url = "${AppConfig.apiUrl}/password/email";
    var body = jsonEncode({
      "email":email,
    });

    var res = await ApiRequest.post(url: url, body: body);
    print(res.body);
    return commonResponseFromJson(res.body);
  }



}