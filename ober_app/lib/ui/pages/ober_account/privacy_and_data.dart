import 'package:flutter/material.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/images.dart';
import 'package:ober_app/dummy_data.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/common_web_view.dart';

class PrivacyAndData extends StatelessWidget {
  const PrivacyAndData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 20, left: StyleConfig.padding, right: StyleConfig.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getLocal(context).privacy,
            style: StyleConfig.fs24,
          ),
          SizedBox(height: 24,),
          Text(getLocal(context).privacy,style: StyleConfig.fs18,),
          SizedBox(height: 14,),
          buildBasicInfoModel(getLocal(context).privacy_center,getLocal(context).privacy_learn_how_we_protect_it,(){
            Uri uri = Uri.parse(AppConfig.baseUrl+"/privacy-policy-page");
            SEORoute.go(context, CommonWebView(uri: uri));
          }),
        ],
      ),
    );
  }

  InkWell buildBasicInfoModel(String title,String data,VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: Decorations.round(),
        // color: isDarkMode?ThemeConfig.extraDarkGrey:ThemeConfig.lightGrey,
        child: Row(
          children: [
            Flexible(
              flex: 11,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: StyleConfig.fs16,),
                  Text(data,style: StyleConfig.fs14,),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Icon(Icons.arrow_forward_ios,size: 18,))
          ],
        ),
      ),
    );
  }
}
