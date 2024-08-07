
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/how_does_ober_work.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/i_need_help_signing.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/signing_up/my_phone_or_email_used.dart';



class SigningUpPage extends StatelessWidget {
  const SigningUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: getLocal(context).signing_up),
      body:Column(
        children: [
          buildHelpModel(getLocal(context).my_phone_or_email_is_already_in_use, () {
            SEORoute.go(context, MyPhoneEmailAlreadyUsed());
          }),
          buildHelpModel(getLocal(context).i_need_help_signing_up_for_a_rider_account, () {
            SEORoute.go(context, INeedHelpSigning());
          }),
          buildHelpModel(getLocal(context).how_does_ober_work, () {
            SEORoute.go(context, HowDoesOberWork());
          }),
        ],
      ) ,
    );
  }
  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.article),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}

