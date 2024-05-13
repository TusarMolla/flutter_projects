import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grostore/presenters/cart_presenter.dart';
import 'package:grostore/presenters/check_out_presenter.dart';
import 'package:grostore/screens/product_details.dart';
import 'package:provider/provider.dart';

class MakeRoute{
 static Navigator route = const Navigator();
 static go(BuildContext context,dynamic newRoute){
    Navigator.push(context, MaterialPageRoute<ProductDetails>(builder: (context)=>newRoute));

 }
 static goAndRemoveAll(context,dynamic newRoute){
   MakeRoute.clearProviders(context);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>newRoute),(route)=>false);
 }

  static productRoute(BuildContext context,Widget route){

   if(context.widget.runtimeType == ProductDetails){

     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>route));
   }else{
     Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
   }
 }
 static goName(BuildContext context, String route){
   Navigator.pushNamed( context, route);
  }


 static clearProviders(BuildContext context){
   Provider.of<CartPresenter>(context,listen: false).clearAll();
   Provider.of<CheckOutPresenter>(context,listen: false).clearAll();
  }


}