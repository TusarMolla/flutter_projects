import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';

import '../../../../custom_widgets/seoAppbar.dart';



class IThinkMyAccountHacked extends StatelessWidget {
  const IThinkMyAccountHacked({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "I think my account has been hacked"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("If you notice suspicious activity on your account or think someone else used it, your account could be compromised. If you can't sign in to your account, try Suspicious activity can include: Trips on your account that you didn't request or take \n• Phone calls or text messages from drivers about pickup when you did not request a trip\n• Receipts for trips on your account that you don't recognize \nChanges you didn't make to your account, payment profile, password, or email.",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}