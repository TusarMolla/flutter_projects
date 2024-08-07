
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/pricing_and_fees/am_i_charged_for_cancelling.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/pricing_and_fees/do_ober_have_recurring_charges.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/pricing_and_fees/do_riders_pay_tolls.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/pricing_and_fees/how_are_fares_calculated.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/pricing_and_fees/wait_time_fees.dart';



class PricingAndFees extends StatelessWidget {
  const PricingAndFees({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: getLocal(context).pricing_and_fees),
      body:Column(
        children: [
          buildHelpModel(getLocal(context).am_i_charged_for_cancelling_a_trip, () {
            SEORoute.go(context, AmICahargedForCancelling());
          }),
          buildHelpModel(getLocal(context).wait_time_fees, () {
            SEORoute.go(context, WaitTimeFees());
          }),
          buildHelpModel(getLocal(context).how_are_fares_calculated, () {
            SEORoute.go(context, HowAreFaresCalculated());
          }),
          /*buildHelpModel("Do riders pay tolls or surcharges?", () {
            SEORoute.go(context, DoRidersPayTolls());
          }),
          buildHelpModel("Does Ober have recurring charges?", () {
            SEORoute.go(context, DoOberHaveRecurringCharges());
          }),*/

        ],
      ) ,
    );
  }
  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.article),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}

