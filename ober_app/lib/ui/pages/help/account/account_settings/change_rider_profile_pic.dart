
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class ChangeRiderProfilePic extends StatelessWidget {
  const ChangeRiderProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Change the profile picture"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("To change or add a profile picture tap your photo or the blank circle in the menu section of your app.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            // Text("If this happens, your app will ask you to pay in cash to the next driver(if cash payment are available in your area) or charge the pending amount to a digital payment method of your choice(like a credit card or debit card).",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}
