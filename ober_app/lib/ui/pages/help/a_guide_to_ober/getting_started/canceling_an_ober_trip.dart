import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class CancelingAnOberTrip extends StatelessWidget {
  const CancelingAnOberTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Canceling an Ober trip"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("""You can cancel a trip in the app before or after you're matched with a driver.""",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("To cancel before you're matched with a driver:",style: StyleConfig.fs24fwBold,),
            Text('1. Tap the white bar at the bottom of your screen that says "Finding your ride."\n2. Tap "Cancel."\n3. Tap "No" to keep your ride or "Yes, cancel" to cancel.',style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("To cancel after you're matched with a driver:",style: StyleConfig.fs24fwBold,),
            Text('1. Tap the bar at the bottom of your screen showing your driver\'s information.\n2. Tap "Cancel trip."\n3. Tap "No" to keep the ride or "Yes, cancel" to cancel and accept the fee.',style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("A cancellation fee may apply if you cancel after you're matched with a driver. These fees pay drivers for the time and effort they spend getting to your location.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Think you were charged a cancellation fee in error?",style: StyleConfig.fs24fwBold,),
            Text("Let us know here. This might happen if your driver canceled instead of ending the trip, or if they canceled because they were too far away from your pickup location.",style: StyleConfig.fs14,),

          ],
        ),
      ),
    );
  }
}
