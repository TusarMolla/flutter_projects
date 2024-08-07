import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class WhyIsTherePendingCharge extends StatelessWidget {
  const WhyIsTherePendingCharge({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Why is there a pending charge on my account"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("What are authorization holds?",style: StyleConfig.fs18,),
            SizedBox(height: 4,),
            Text("Authorization holds are small amounts of money that are never actually charged to your account. However, you may notice one of these amounts listed on your account as pending.",style: StyleConfig.fs14,),
            SizedBox(height: 18,),
            Text("When you might see a authorization hold",style: StyleConfig.fs18,),
            SizedBox(height: 4,),
            Text("At the start of a trip, Uber may place a temporary authorization hold for the upfront price of the trip on your payment method. This will show up as a 'pending' charge on your account's payment method. When the trip completes, this authorization hold is converted to a charge for the final trip price. If the trip has been canceled or the total price is different than the upfront price in your app, the original authorization hold should be voided from your payment method. Authorization holds may take up to 2 weeks to clear depending on your bank's processing times.",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}
