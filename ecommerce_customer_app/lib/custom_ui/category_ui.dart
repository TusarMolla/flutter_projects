import 'package:flutter/material.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/helpers/device_info_helper.dart';


class CategoryUi extends StatelessWidget {
 late String img,name;
   CategoryUi({Key? key,required this.img,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:BoxDecorations.shadow(radius: 6.0) ,
      width: getWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageView(url: img,width:40.0,height: 40.0,),
          SizedBox(height: 8,),
          Text(name,style: StyleConfig.fs12,maxLines: 1,textAlign: TextAlign.center,)
        ],
      )
    );
  }
}
