import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/helpers/main_helper.dart';




class ICantClearPendingAmount extends StatelessWidget {
  const ICantClearPendingAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "I can't clear a pending amount"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("If a charge from Ober is declined by your payment method or you gave the driver less than the price that was owed, you were put into pending amounts and may not be able to request a ride.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("If this happens, your app will ask you to pay in cash to the next driver(if cash payment are available in your area) or charge the pending amount to a digital payment method of your choice(like a credit card or debit card).",style: StyleConfig.fs14,),
            /*Text("You can also pay a pending amount using a digital payment.",style: StyleConfig.fs14,),
            Text("1. Tap your name in the top right and select wallet ",style: StyleConfig.fs14,),
            Text("",style: StyleConfig.fs14,),
            Text("",style: StyleConfig.fs14,),
            Text("",style: StyleConfig.fs14,),*/


          ],
        ),
      ),
    );
  }
}
//“”