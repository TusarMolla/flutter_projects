import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/helpers/main_helper.dart';

class Loader{
  static  BuildContext ?context;

 static show(BuildContext context){
    return showDialog(context: context, builder: (alertContext) {
      Loader.context = alertContext;
      return AlertDialog(
        backgroundColor: themeBoxColor,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(width: 10,),
            Text("Loading...",style: StyleConfig.fs16,),
          ],
        ),
      );
    }
    );

  }

 static hide(){
    Navigator.pop(context!);
  }



}