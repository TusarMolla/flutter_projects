import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/account/account_settings/adding_save_places.dart';
import 'package:ober_app/ui/pages/help/account/account_settings/change_rider_profile_pic.dart';
import 'package:ober_app/ui/pages/help/account/account_settings/delete_my_ober_account.dart';
import 'package:ober_app/ui/pages/help/account/account_settings/i_would_like_know_rating.dart';
import 'package:ober_app/ui/pages/help/account/account_settings/update_my_profile.dart';
import 'package:ober_app/ui/pages/help/account/payment_methods/paying_with_cash.dart';
import 'package:ober_app/ui/pages/help/account/payment_methods/updating_payment_method.dart';



class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Payment methods"),
      body:Column(
        children: [
          buildHelpModel("Updating a payment method on your account", () {
            SEORoute.go(context, UpdatingPaymentMethod());
          }),
          buildHelpModel("Paying with cash", () {
            SEORoute.go(context, PayingWithCash());
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

