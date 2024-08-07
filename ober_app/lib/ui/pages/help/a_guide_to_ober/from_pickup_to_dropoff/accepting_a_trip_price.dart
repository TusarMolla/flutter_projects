import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class AcceptingATripPrice extends StatelessWidget {
  const AcceptingATripPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Accepting a trip price"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Once you request your ride, you've accepted the price shown in the app.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Upfront pricing",style:StyleConfig.fs24fwBold,),
            Text("""
If upfront pricing is available in your city, you'll see the price for a trip next to each vehicle option. Upfront prices account for:
The rate for time and distance to your destination
• Applicable fees, tolls and surcharges
Note: You might not see an upfront price if you request a long trip, or if you request the trip too fast for the app to calculate the price.
The upfront price you're shown may change due to a number of circumstances which may include:
• Adding stops
Updating your destination
• Significant changes to the route or duration of your trip
You pass through a toll that was not factored into your upfront price            
            """,style: StyleConfig.fs14,),

            Text("In addition, you may incur wait time fees for the time you take to get to the car at the pickup or multi-stop fees for time spent at an on-trip stop.Note: Time and distance pricing does not apply to all Uber rideshare products.",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}
