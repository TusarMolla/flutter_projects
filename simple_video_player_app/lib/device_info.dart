

import 'package:flutter/material.dart';

class DeviceInfo{
 late double width;
 late double height;

 DeviceInfo(context){
   width = MediaQuery.of(context).size.width;
   height =MediaQuery.of(context).size.height;
 }
}