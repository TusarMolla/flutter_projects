import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/helpers/common_functions.dart';

class ImageView extends StatelessWidget {
  late String url;
  double width, height;
  double? radius;

  ImageView({Key? key, required this.url, this.width = 10, this.height = 10,this.radius = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child:url.isNotEmpty?
      CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(getAssetLogo("logo.png"),color: ThemeConfig.xxlightGrey,),
        errorWidget: (context, url, error) => _placeHolder(),
      ):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(getAssetLogo("logo.png"),color: ThemeConfig.xxlightGrey,),
      ),
    );
  }

  show(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) => Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
            height: 10,
          )
        ],
      ),
      errorWidget: (context, url, error) => _placeHolder(),
    );
  }

 static round({
    required BuildContext context,
    required double radius,
    required url,
    required height,
    required width,
  }) {
    return Container(
      height:double.parse(height.toString()) ,
      width: double.parse(width.toString()),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(double.parse(radius.toString())),
        image:url!=null? DecorationImage(image: NetworkImage(url)):DecorationImage(image:AssetImage(getAssetIcon("profile.png"))),

      ),

    );
    //CircleAvatar()
  }

  static svg({required String url,double height=40,double width=40}){
    if( url.isEmpty){
      return Container(
          child: _staticPlaceHolder());
          }

    return SvgPicture.network(
      url,
      height:height ,
      width: width,
      fit: BoxFit.contain,
      placeholderBuilder: (BuildContext context) => Container(
        child: _staticPlaceHolder(),
      ),
    );
  }

  static roundFileImage({
    required BuildContext context,
    required double radius,
    required File file,
    required height,
    required width,
  }){
  return  Container(
      height:double.parse(height.toString()) ,
      width: double.parse(width.toString()),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(double.parse(radius.toString())),
        image:file !=null? DecorationImage(image: FileImage(file)):DecorationImage(image:AssetImage(getAssetIcon("profile.png"))),

      ),

    );
  }


 Widget _placeHolder(){
    return Image.asset(getAssetLogo("logo.png"),color: ThemeConfig.xxlightGrey,);
  }
 static Widget _staticPlaceHolder(){
    return Image.asset(getAssetLogo("logo.png"),color: ThemeConfig.xxlightGrey,);
  }
}
