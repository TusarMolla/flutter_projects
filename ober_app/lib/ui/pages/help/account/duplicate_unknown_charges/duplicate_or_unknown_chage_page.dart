import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/account/duplicate_unknown_charges/i_was_charged.dart';
import 'package:ober_app/ui/pages/help/account/duplicate_unknown_charges/why_is_there_pending_charge.dart';




class DuplicateOrUnknownChargesPage extends StatelessWidget {
  const DuplicateOrUnknownChargesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Duplicate or unknown charges"),
      body:Column(
        children: [
          buildHelpModel("I was charged for a ride I didn't take", () {
            SEORoute.go(context, IWasChargedForARide());
          }),
          buildHelpModel("Why is there a pending charge on my account?", () {
            SEORoute.go(context, WhyIsTherePendingCharge());
          }),
          // buildHelpModel("I cant add or delete payment methods", () {
          //   SEORoute.go(context, DeleteMyOberAccount());
          // }),
        ],
      ) ,
    );
  }
  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.article),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}