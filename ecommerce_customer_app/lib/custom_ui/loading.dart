


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';

class Loading{
  static  BuildContext? _context;

  static show(BuildContext context){
    Loading._context=context;
    showDialog(context: context, builder: (context){
        return  AlertDialog(content: Container(
          child: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20,),
              Text(AppLang.local(context).please_wait_ucf),
            ],
          ),
        ),);
    });
  }

 static close(){
    if(Loading._context!=null){
      Navigator.pop(_context!);
    }
  }
}
