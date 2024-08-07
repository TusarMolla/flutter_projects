import 'package:flutter/cupertino.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:toast/toast.dart';

class SEOToast{

static  show(BuildContext context,message,{gravity=Toast.center,duration = Toast.lengthLong}){
    ToastContext().init(context);
    Toast.show(message.toString(), backgroundColor: themeBoxColor,textStyle: StyleConfig.fs14fwBold.copyWith(fontWeight: FontWeight.normal),border: Border.all(width: 1,color: ThemeConfig.grey,),gravity: gravity,duration: duration);
  }

}

