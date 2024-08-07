import 'package:flutter/material.dart';

class SEORoute{
 static Navigator route = const Navigator();

 static Future<T?> go<T extends Object?>(BuildContext context,dynamic newRoute){
   return Navigator.push<T>(context, MaterialPageRoute(builder: (context)=>newRoute));
 }

 static goAndRemoveAll(context,dynamic newRoute){
   // MakeRoute.clearProviders(context);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>newRoute),(route)=>false);
 }
 static goName(BuildContext context, String route){
   Navigator.pushNamed( context, route);
  }




}