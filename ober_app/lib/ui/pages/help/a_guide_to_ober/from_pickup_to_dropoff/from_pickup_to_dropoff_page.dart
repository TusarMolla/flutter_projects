
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/from_pickup_to_dropoff/accepting_a_trip_price.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/from_pickup_to_dropoff/book_a_rdie_for_else.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/from_pickup_to_dropoff/contact_a_driver.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/from_pickup_to_dropoff/how_to_tip_a_driver.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/from_pickup_to_dropoff/share_your_location.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/canceling_an_ober_trip.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/requesting_a_specific_driver.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/requesting_long_trips.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/scheduling_a_ride.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/getting_started/someone_else_booked.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/how_does_ober_work.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/i_need_help_signing.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/my_phone_or_email_used.dart';



class FromPickupToDropoffPage extends StatelessWidget {
  const FromPickupToDropoffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "From pickup to dropoff"),
      body:Column(
        children: [
          buildHelpModel("Contact a driver", () {
            SEORoute.go(context, ContactADriver());
          }),
          buildHelpModel("How to tip a driver", () {
            SEORoute.go(context, HowToTipADriver());
          }),
          buildHelpModel("Accepting a trip price", () {
            SEORoute.go(context, AcceptingATripPrice());
          }),
          buildHelpModel("Share your location", () {
            SEORoute.go(context, SharingYourLocation());
          }),
          buildHelpModel("Book a ride for someone else", () {
            SEORoute.go(context, BookARideForElse());
          }),
        ],
      ) ,
    );
  }
  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.article),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}

