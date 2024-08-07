import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/help/a_guide_to_ober/a_guide_to_ober_page.dart';
import 'package:ober_app/ui/pages/help/account/account_help.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: getLocal(context).help),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getLocal(context).all_topics,style: StyleConfig.fs18,),
            // buildHelpModel("Help with a trip",(){}),
            // SizedBox(height: 8,),
            buildHelpModel(getLocal(context).account,(){
              SEORoute.go(context, AccountHelp());
            }),
            buildHelpModel(getLocal(context).a_guide_to_ober,(){
              SEORoute.go(context, AGuideToOberPage());
            }),
            // buildHelpModel("Accessibility",(){
            //   SEORoute.go(context, AccountHelp());
            // }),
          ],
        ),
      ),
    );
  }

  ListTile buildHelpModel(String title,VoidCallback onTap) => ListTile(leading: Icon(Icons.list),title: Text(title),titleTextStyle: StyleConfig.fs14,iconColor: themeColor,trailing: Icon(Icons.arrow_forward_ios,size: 16,),onTap: onTap,);

}
