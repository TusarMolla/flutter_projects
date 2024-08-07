import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class PayingWithCash extends StatelessWidget {
  const PayingWithCash({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Paying with cash"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("You can delete ",style: StyleConfig.fs18,),
            Text("""Ober is designed to be an entirely cashless experience in most cities.\n\nWhen a trip ends, the payment method selected for your trip is immediately charged. A receipt is emailed to you, and your account's trip history is updated with details about the route and fare.\n\nTipping is not required on Uber rides. Giving a driver a cash tip is left to your discretion.""",style: StyleConfig.fs14,),

          ],
        ),
      ),
    );
  }
}
