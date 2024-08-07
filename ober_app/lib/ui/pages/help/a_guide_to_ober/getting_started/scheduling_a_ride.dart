import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';

class SchedulingARide extends StatelessWidget {
  const SchedulingARide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SeoAppbar.build(title: "Scheduling a ride in advance"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Schedule an Ober ride 30 minutes to 30 days in advance of when you'd like to be picked up by tapping the clock icon before you confirm your ride.",
              style: StyleConfig.fs14,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "How scheduled rides work",
              style: StyleConfig.fs24fwBold,
            ),
            Text(
              "The scheduled rides feature allows you to select a time for a driver to come pick you up. The app will send a ride request for you before your selected pickup time. You'll get push notifications when you're matched with a driver and when they're nearby, like you do with other rides. Keep in mind:\n• Scheduling a ride in advance doesn't guarantee you'll be connected with a driver.\n• We'll notify you in the rare case you're not connected with a driver.\n• Dynamic pricing may be in effect at the time of your ride. We'll let you know if your price has changed.",
              style: StyleConfig.fs14,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "To schedule a ride:",
              style: StyleConfig.fs24fwBold,
            ),
            Text(
              "1. Enter your destination in the 'Where to?' field. 2. Swipe through vehicle options and tap one to select it for your ride.\n3. Tap the clock icon next to the 'Choose' button. 4. Set the date and time for your pickup.\n5. Tap 'Set pickup time.'\n6. Update your pickup location if necessary, then tap 'Reserve.'\n7. Confirm your pickup location by tapping 'Confirm pickup'",
              style: StyleConfig.fs14,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "To cancel a scheduled ride:",
              style: StyleConfig.fs24fwBold,
            ),
            Text(
              '1. From the main screen, tap "Account" and then "Trips."\n2. Select the "Past" dropdown and then "Upcoming."\n3. Beneath the ride you want to cancel, tap "Cancel ride."\n4. Confirm the cancellation by tapping "Cancel reservation."',
              style: StyleConfig.fs14,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "You can cancel your request at any point before being matched with a driver without any charge. Normal cancellation fees apply once a driver accepts your trip request.",
              style: StyleConfig.fs14,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Where and when is this available?",
              style: StyleConfig.fs24fwBold,
            ),
            Text(
              "Check your app to see if scheduled rides are available in your area. If available, you can schedule a ride any time of day. You can schedule trips to the airport, but not when leaving an airport. If you're leaving an airport, you should request an on-demand ride.",
              style: StyleConfig.fs14,
            ),

          ],
        ),
      ),
    );
  }
}
