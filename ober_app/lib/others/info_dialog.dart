import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';

class InfoDialog{


  static  show({required BuildContext context,required String title,required String content,required void Function() onPressOk,String okText="Ok"}){
    showCupertinoDialog(context: context, builder:(context)=>CupertinoAlertDialog(
      title: Text(title,style: StyleConfig.fs14fwBold,),
      content: Text(content,style: StyleConfig.fs14,),

      actions: [

        CupertinoDialogAction(
            onPressed: (){
              Navigator.pop(context);

              onPressOk();
            },

            // color: Colors.grey,
            child: Text(okText,style: StyleConfig.fs14cWhitefwNormal.copyWith(color: Colors.red),)),
      ],
    ));
  }

}