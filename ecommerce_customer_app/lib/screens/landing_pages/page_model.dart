import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/device_info_helper.dart';


class PageModel extends StatelessWidget {
  String img,headerTxt,txt;
  PageModel({Key? key,required this.img,required this.headerTxt,required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLang.setContext(context);
    return  SizedBox(

      child: Center(
        child: Column(
          children: [
            Image.asset(getAssetImage(img),height: getHeight(context)*0.7,width: getWidth(context),fit: BoxFit.cover,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:StyleConfig.padding),
              child: Column(
                children: [
                  Text(
                    headerTxt,
                    style: StyleConfig.fs22fwEBold,textAlign: TextAlign.center,),
                  SizedBox(height: 10,),
                  Text(
                    txt,
                    style: StyleConfig.fs12cLightfwEBold,textAlign: TextAlign.center,),
                ],
              ),
            ),

          ],
        ),
        
      ),
    );
  }
}
