





import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';

class SeoAppbar  {
   SeoAppbar();

 static AppBar build({required title,PreferredSize? bottom}) {
    return  AppBar(
      title: Text(title,style: StyleConfig.fsAppbar,),
      bottom: bottom,
    );
  }
}
