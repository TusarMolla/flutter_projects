import 'package:flutter/cupertino.dart';

class DeviceInfo{
  static  BuildContext? context;
 static set initInfo(context){
   DeviceInfo.context ??= context;
  }
  DeviceInfo(BuildContext buildContext){
   initInfo=buildContext;
  }

  static get width=>
      // Get.context?.size?.width??200.0;
      MediaQuery.of(context!).size.width;

  static get height=>
      // Get.context?.size?.height??500.0;
     MediaQuery.of(context!).size.height;
}