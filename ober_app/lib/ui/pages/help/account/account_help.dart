


import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/account/account_settings/account_setting_page.dart';
import 'package:ober_app/ui/pages/help/account/cant_signin_or_request/cant_signin_or_request_page.dart';
import 'package:ober_app/ui/pages/help/account/duplicate_unknown_charges/duplicate_or_unknown_chage_page.dart';
import 'package:ober_app/ui/pages/help/account/i_think_my_account_hacked.dart';
import 'package:ober_app/ui/pages/help/account/payment_methods/payment_methods_page.dart';

class AccountHelp extends StatelessWidget {
  const AccountHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Help | Account"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHelpModel("Can't sign in or request a trip",(){
              SEORoute.go(context, CantSingninOrRequest());
            }),
            // SizedBox(height: 8,),
            buildHelpModel("Account settings",(){
              SEORoute.go(context, AccountSettingPage());
            }),
            buildHelpModel("Payment Methods",(){
              SEORoute.go(context, PaymentMethodsPage());
            }),
            buildHelpModel("Duplicate or unknown charges",(){
              SEORoute.go(context, DuplicateOrUnknownChargesPage());
            }),
            buildHelpModel("I think My account has been hacked",(){
              SEORoute.go(context, IThinkMyAccountHacked());
            }),
          ],
        ),
      ),
    );
  }

  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.list),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}
