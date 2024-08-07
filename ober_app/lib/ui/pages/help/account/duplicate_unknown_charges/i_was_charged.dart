import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class IWasChargedForARide extends StatelessWidget {
  const IWasChargedForARide({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "I was charged for a ride I didn't take"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("You can delete ",style: StyleConfig.fs18,),
            Text("""If someone else took the trip you requested but you were charged for the trip, you can let us know on this page.
Before contacting us, it's a good idea to check with friends or family members who have access to your account or payment method.
If you believe you were incorrectly charged a cancellation fee, go back in your trip history and select the trip in question. Under the trip select "Review my cancellation fee" and we'll look in to it.""",style: StyleConfig.fs14,),

          ],
        ),
      ),
    );
  }
}
