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



class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Account Settings"),
      body:Column(
        children: [
          buildHelpModel("Change the profile picture", () {
            SEORoute.go(context, ChangeRiderProfilePic());
          }),
          buildHelpModel("Update my profile", () {
            SEORoute.go(context, UpdateMyProfile());
          }),
          buildHelpModel("Delete my Ober account", () {
            SEORoute.go(context, DeleteMyOberAccount());
          }),
          buildHelpModel("I would like to know my rating", () {
            SEORoute.go(context, IWouldLikeToKnowRating());
          }),
          buildHelpModel("Adding saved places on Android/iOS", () {
            SEORoute.go(context, AddingSavePlaces());
          }),
        ],
      ) ,
    );
  }
  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.article),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}

