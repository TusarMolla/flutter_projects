import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/custom_models/user_data.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/helpers/shared_value_helper.dart';
import 'package:ober_app/main.dart';
import 'package:ober_app/models/common_response.dart';
import 'package:ober_app/others/api_request.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/repositories/auth_repository.dart';
import 'package:ober_app/repositories/profile_repository.dart';
import 'package:ober_app/ui/pages/auth/login_page.dart';
import 'package:ober_app/ui/pages/main.dart';

class Auth{


  static storeToken(token){
    access_token.$= token;
    access_token.save();
  }
  static clearToken(){
    access_token.$= "";
    access_token.save();
  }


  static logout(BuildContext context)async{
  return  Dialogs.yesNo(context: context, title: "Logout Info", content: "Do you want to logout?", yesOnClick:()=>_logout(context) );
  }

 static _logout(BuildContext context)async{
    Loader.show(context);
    var res = await AuthRepository.logout();
    Loader.hide();
    SEOToast.show(context, res.message);
    clearToken();
    SEORoute.goAndRemoveAll(context, LoginPage());
  }

  static Future<void> check()async{

    var res = await AuthRepository.getInfo();
      if(res.user != null){
        SystemData.userData = res.user;
        SystemData.isLogedIn = true;
      }
  }

  static Future<void> getRating()async{

    var res = await ProfileRepository.getRating();
      if(res.rating != null){
        SystemData.userRating = res;
      }
  }


}