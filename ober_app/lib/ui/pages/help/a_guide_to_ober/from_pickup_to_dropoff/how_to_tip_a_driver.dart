import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class HowToTipADriver extends StatelessWidget {
  const HowToTipADriver({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "How to tip a driver"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tipping is a great way to thank a driver for a good experience. Tips are voluntary and aren't included in the fare. The entire tip amount goes directly to the driver.\nAt the end of each trip, you'll be prompted to rate and tip the driver in the app.\nYou can also tip a driver during a trip:\n",style: StyleConfig.fs14,),

            Text('1. Open the Ober app.\n2. Tap the white screen to expand the trip details. \n3. Tap "Rate or tip" next to "How\'s your ride going?"\n4. Select the number of stars you want to rate the driver.\n5. If you selected 5 stars, you\'ll be prompted to tip the driver. If you selected less than 5 stars, you\'ll see the option to add a tip.\n6. Tap "Save"\nYou may also use cash to tip the driver.',style: StyleConfig.fs14,),



          ],
        ),
      ),
    );
  }
}
