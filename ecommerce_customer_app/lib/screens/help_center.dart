import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/presenters/help_center_presenter.dart';
import 'package:url_launcher/url_launcher.dart';


class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  HelpCenterPresenter helpCenterPresenter=HelpCenterPresenter();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      helpCenterPresenter.initState();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.xxlightGrey,
      appBar: CommonAppbar.show(title: AppLang.local(context).help_center_ucf, context: context),
    body: Center(
      child: ListenableBuilder(
        listenable: helpCenterPresenter,
        builder: (context,child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
            height: 200,
            width: getWidth(context),
            decoration: BoxDecorations.shadow(radius: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(
                      width: getWidth(context)*0.7,
                        child: Text(helpCenterPresenter.helpCenter?.location??""))

                  ],
                ),
                SizedBox(height: 10,),
                Button(
                  onPressed: (){
                    launchUrl(Uri(scheme: 'tel', path: helpCenterPresenter.helpCenter?.contactNumber??"123"));

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone),
                      SizedBox(
                        width: getWidth(context)*0.7,
                          child: Text(helpCenterPresenter.helpCenter?.contactNumber??""))

                    ],
                  ),
                ),
                Button(
                  onPressed: (){
                    launchUrl(Uri(scheme: 'mailto', path: helpCenterPresenter.helpCenter?.email??""));

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(
                        width: getWidth(context)*0.7,
                          child: Text(helpCenterPresenter.helpCenter?.email??""))

                    ],
                  ),
                ),

              ],
            ),
          );
        }
      ),
    ),
    
    );
  }
}
