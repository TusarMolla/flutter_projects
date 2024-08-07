import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class DoRidersPayTolls extends StatelessWidget {
  const DoRidersPayTolls({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Do riders pay tolls or surcharges"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("""
To get the most accurate information for your region, select your city at the top right of the page.
Additional charges may apply to your trip, including tolls, surcharges, or other fees. These charges are automatically added to your trip fare.
Please note that charges added to your trip fare may not exactly match the amount paid by your driver. For example, you may be assessed a surcharge when a driver pays a toll when returning to your city of origin, or for pickups or dropoffs at an airport.
You may also be charged the standard amount of a toll when the driver is entitled to a discount because they are:
• In a High-Occupancy Vehicle lane
• Driving an electric vehicle
• Using a transponder
In some cities, tolls and surcharges reflect an estimate. This is due to fluctuations in the amount actually paid. You may also pay an additional charge to your driver for other costs or inconveniences, such as a parking fee to enter a venue or a long return trip after arrival at your final destination.Depending on the charge and location, these additional charges may be:
Retained by your driver
Paid by your driver
Passed through to the airport or other third parties
            """,style: StyleConfig.fs14,),


          ],
        ),
      ),
    );
  }
}
