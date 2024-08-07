import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class RequestingLongTrips extends StatelessWidget {
  const RequestingLongTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Requesting long trips"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("""
While Uber doesn't limit the distance you can travel on a trip, trips may automatically end after 4 hours. When this is about to happen, the driver is notified by the partner app.
Please let drivers know if you're planning to travel a long distance. Many drivers need to make the return trip home after reaching your destination, and it's polite to give them a warning of a long trip.
If you'd like to continue after a trip automatically ends, please request a new ride. Since your previous driver is nearby, they may receive this new trip request.""",style: StyleConfig.fs14,),

          ],
        ),
      ),
    );
  }
}
