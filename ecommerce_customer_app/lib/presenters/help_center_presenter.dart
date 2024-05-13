


import 'package:flutter/cupertino.dart';
import 'package:grostore/apis/setting_api.dart';
import 'package:grostore/models/help_center_response.dart';

class HelpCenterPresenter extends ChangeNotifier{

  HelpCenterResponse? helpCenter;


  getData()async{
    var response = await SettingApi.getHelpCenter();
    helpCenter=response.object;
    notifyListeners();
  }

  initState(){
    getData();
  }

 Future<void> onRefresh()async{
    clear();
   return getData();
  }
  clear(){
    helpCenter=null;
  }

}