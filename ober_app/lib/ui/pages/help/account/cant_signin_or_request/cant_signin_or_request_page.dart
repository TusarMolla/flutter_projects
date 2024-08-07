import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/account/cant_signin_or_request/i_cant_clear_a_pending_amount.dart';
import 'package:ober_app/ui/pages/help/account/cant_signin_or_request/i_left_my_phone.dart';
import 'package:ober_app/ui/pages/help/account/cant_signin_or_request/i_lost_access.dart';


class CantSingninOrRequest extends StatelessWidget {
  const CantSingninOrRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Can't Sign in or request a trip"),
      body:Column(
        children: [
          buildHelpModel("I left my phone in a vehicle", () {
            SEORoute.go(context, ILeftMyPhone());
          }),
          buildHelpModel("I can't clear a pending amount", () {
            SEORoute.go(context, ICantClearPendingAmount());
          }),
          buildHelpModel("I lost access to my phone number", () {
            SEORoute.go(context, ILostAccess());
          }),
        ],
      ) ,
    );
  }
  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.article),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}
