import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ober_app/helpers/main_helper.dart';




class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

static Widget circleContainer({required String assetUrl,required double height , required double width, Color? color,Color? imageColor}){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        image: DecorationImage(image: AssetImage(assetUrl)),
        borderRadius: BorderRadius.circular(height*0.5)
      ),
    );
  }
static Widget networkCircle({required String imageUrl,required double height , required double width, Color? color,Color? imageColor}){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        image:imageUrl.isEmpty ?DecorationImage(image: AssetImage(getAssetLogo("logo.png"))): DecorationImage(image: NetworkImage(imageUrl),),
        borderRadius: BorderRadius.circular(height*0.5),
        border: Border.all(color: themeBoxColor,width: 2)
      ),
    );
  }
static Widget fileCircle({required File imageFile,required double height , required double width, Color? color,Color? imageColor}){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        image: DecorationImage(image: FileImage(imageFile)),
        borderRadius: BorderRadius.circular(height*0.5)
      ),
    );
  }

  static Widget fileSquire({required File imageFile,required double size , Color? color,Color? imageColor}){
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: color,
          image: DecorationImage(image: FileImage(imageFile)),
          borderRadius: BorderRadius.circular(5)
      ),
    );
  }

}
