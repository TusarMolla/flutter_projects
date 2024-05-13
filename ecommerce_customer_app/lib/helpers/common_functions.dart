import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/presenters/main_persenter.dart';
import 'package:grostore/screens/main.dart';
import 'package:provider/provider.dart';

bool isEmail(String input){
 return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(input);
}

resetApp(BuildContext context){
 Provider.of<MainPresenter>(context, listen: false).dispose();
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Main()), (route) => false);
}

getAssetImage(String img){
 return "assets/images/$img";
}
getAssetIcon(String icon){
 return "assets/icons/$icon";
}
getAssetLogo(String logo){
 return "assets/logos/$logo";
}
getAssetFlag(String name){
 return "assets/flags/$name";
}


String getQueryParameter(BuildContext context , String key){
 String value = "";
final path = ModalRoute.of(context);
 if(path !=null) {
 String url = path.settings.name!;
    List route = url.split("?");
    if (route.isNotEmpty && route[1] != "") {
      List qParameters = route[1].split("&");

      qParameters.forEach((element) {
        List tmp = element.split("=");
        if (tmp.isNotEmpty && tmp[0]==key) {
          value = tmp[1];
        }
      });
    }
  }
  return value;
}

Map<String,String> getCurrencyHeader(){
  return system_currency.$.isNotEmpty?{
    "Currency-Code": system_currency.$
  }:{};
}

Map<String,String> getCommonHeader(){
  return {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "App-Language": app_language.$,
    "Stock-Location-Id":stock_location_id.$
  };
}

  Map<String,String> getCouponHeader(){
    return {
      "Coupon-Code":SystemData.couponCode
    };
}

String showPrice(String price){
  return price;
    //price.replaceAll(SystemData.systemCurrency?.code??"", SystemData.systemCurrency?.symbol??"");
}