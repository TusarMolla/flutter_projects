import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/main_helper.dart';


class InputDecorations{


  static InputDecoration round({required IconData prefix,bool isPassword = false,required String hint}){
    return  InputDecoration(
      hintText:hint ,
        prefixIcon: Icon(prefix,size: 24,color: themeTxtColor,),
        fillColor: themeBoxColor,
        hintStyle: StyleConfig.fs14cGrey,

        filled: true,
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: ThemeConfig.accentColor)
        ),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: themeBoxColor)
        ),
        contentPadding: EdgeInsets.only(left: 14,right: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: themeBoxColor)
        )
    );
  }
  static InputDecoration normal({bool isPassword = false, String? hint, double radius = 10}){
    return  InputDecoration(
      hintText:hint ,
        // fillColor: themeBoxColor,
        hintStyle: StyleConfig.fs14.copyWith(color: ThemeConfig.lightGrey),
        filled: true,

        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: themeColor)
        ),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: ThemeConfig.noColor)
        ),
        contentPadding: EdgeInsets.only(left: 14,right: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: ThemeConfig.noColor)
        )
    );
  }

}