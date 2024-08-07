import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class UpdatingPaymentMethod extends StatelessWidget {
  const UpdatingPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "updating a payment method on your account"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("You can delete ",style: StyleConfig.fs18,),
            Text("Adding and selecting a preferred payment method will allow you to request a ride. Depending on your country and city, you can add payment methods such as credit cards, cash, or a PayPal account. When a ride ends, your selected payment method is charged. \n\nDuring a ride, use your app to check that your preferred payment method is selected. Swipe up from the bottom of the app and tap your desired payment method before the trip ends.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("To add a payment method:",style: StyleConfig.fs18,),
            Text('1. Select "Account" and then "Wallet" in your app.',style: StyleConfig.fs14,),
            Text('2. Tap "Add Payment Method".',style: StyleConfig.fs14,),
            Text("3. Add a payment method by scanning a card, manually entering card info, or adding an alternative payment type.",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}
