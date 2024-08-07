
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/canceling_an_ober_trip.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/requesting_a_specific_driver.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/requesting_long_trips.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/scheduling_a_ride.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/someone_else_booked.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/how_does_ober_work.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/i_need_help_signing.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/my_phone_or_email_used.dart';



class GettingStarted extends StatelessWidget {
  const GettingStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Getting started"),
      body:Column(
        children: [
          buildHelpModel("Someone else booked me a ride", () {
            SEORoute.go(context, SomeoneElseBooked());
          }),
          buildHelpModel("Scheduling a ride in advance", () {
            SEORoute.go(context, SchedulingARide());
          }),
          buildHelpModel("Requesting a specific driver", () {
            SEORoute.go(context, RequestingASpecificDriver());
          }),
          buildHelpModel("Requesting long trips", () {
            SEORoute.go(context, RequestingLongTrips());
          }),
          buildHelpModel("Canceling an Ober trip", () {
            SEORoute.go(context, CancelingAnOberTrip());
          }),
        ],
      ) ,
    );
  }
  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.article),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}

