import 'dart:io';

import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/models/common_response.dart';
import 'package:ober_app/models/profile_info_response.dart';
import 'package:ober_app/models/rating_response.dart';
import 'package:ober_app/others/api_request.dart';

class ProfileRepository{
  
  static Future<ProfileInfoResponse> getDetails()async{
    var response = await ApiRequest.get(url: getApiPath("passenger/profile/details"),header: getAuthHeader);
    if(response.getError().error??false){
      return ProfileInfoResponse().setErrors(response.getError());
    }

    return profileInfoResponseFromJson(response.body);

  }

  static Future<CommonResponse> update(Map<String,String> body,File? file,String fileKey)async{
    var response = await ApiRequest.fileReq(url: getApiPath("passenger/profile/update"),header: getAuthHeader,body:body,file: file,fileKey: fileKey );
    print(response.body);
    return commonResponseFromJson(response.body);

  }
  static Future<RatingResponse> getRating()async{
    var response = await ApiRequest.get(url: getApiPath("get-user-rating"),header: getAuthHeader);

    var tmp =  ratingResponseFromJson(response.body);
    return tmp;
  }

}