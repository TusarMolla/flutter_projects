import 'dart:convert';
import 'dart:io';
import 'package:grostore/middlewares/middleware.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  static Future<ApiResponse> post(
      {required String url,
     required Map<String, String> header,
     required String body,
      MiddleWare? middleWare}) async {
    try {
      Uri uri = Uri.parse(url);
      var response = await http.post(uri, body: body, headers: header);
      if (middleWare != null) {
        if (middleWare.next(response.body)) {
          return ApiResponse(result: true,body:  response.body,statusCode: 200);
        } else {
          return ApiResponse(result: false,body:  "Something went wrong",statusCode: 403);
        }
      } else {
        return ApiResponse(result: true,body:  response.body ,statusCode: 200);
      }
    } on Exception catch (e) {
      return ApiResponse(result: false,body:  "Something went wrong ${e.toString()}",statusCode: 500);
    }
  }

  static Future<ApiResponse> fileReq(
      {required String url,
     required Map<String, String> header,
        Map<String,String>? body,
        File? file,
      MiddleWare? middleWare}) async {
    try {
      Uri uri = Uri.parse(url);

      var req =  http.MultipartRequest("Post",uri);
      req.headers.addAll( header);


      if(file !=null) {
        req.files.add(await http.MultipartFile.fromPath("avatar", file.path));
      }

      if(body !=null){
        req.fields.addAll(body);
      }

     var tmp = await req.send();

    var  response= await tmp.stream.bytesToString();


      if (middleWare != null) {
        if (middleWare.next(response)) {
          return ApiResponse(result: true,body:  response,statusCode: 200);
        } else {
          return ApiResponse(result: false,body:  "Something went wrong",statusCode: 403);
        }
      } else {
        return ApiResponse(result: true,body:  response ,statusCode: 200);
      }
    } on Exception catch (e) {
      return ApiResponse(result: false,body:  "Something went wrong ${e.toString()}",statusCode: 500);
    }
  }

  static Future<ApiResponse> get(String url, Map<String, String> header,
      {MiddleWare? middleWare}) async {
    try {
      Uri uri = Uri.parse(url);
      var response = await http.get(uri, headers: header);
     // print(response.body);
      if (middleWare != null) {
        if (middleWare.next(response.body)) {
          return ApiResponse(result: true,body: response.body,statusCode: 200);
        } else {
          return ApiResponse(result: false,body:  "Something went wrong",statusCode: 403);
        }
      } else {
        return ApiResponse(result: true,body:  response.body,statusCode:200 );
      }
    } on Exception catch (e) {
      return ApiResponse(result: false,body:  "Something went wrong",statusCode: 500);
    }
  }


}

class ApiResponse {
  bool result;
  String body;
  int statusCode ;

  ApiResponse({required this.result,required this.body,required this.statusCode});
}
