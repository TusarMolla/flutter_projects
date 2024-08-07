


import 'package:flutter/cupertino.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/main_helper.dart';

class Decorations{



 static BoxDecoration round({double radius=8}){
    return BoxDecoration(
      color:isDarkMode ? ThemeConfig.extraDarkGrey:ThemeConfig.lightGrey,
      borderRadius: BorderRadius.circular(radius),
    );
  }
 static BoxDecoration border({double radius=8}){
    return BoxDecoration(
      color:isDarkMode ? ThemeConfig.extraDarkGrey:ThemeConfig.lightGrey,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: themeTxtColor,width: 1)
    );
  }
}