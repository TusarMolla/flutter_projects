import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/screens/auth/login.dart';
import 'package:grostore/screens/auth/registration.dart';

import '../../helpers/device_info_helper.dart';

class AuthPageModel extends StatelessWidget {
  const AuthPageModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
      width: getWidth(context),
      height: getHeight(context),
      decoration: BoxDecoration(
          //color: ThemeConfig.splashBackgrund,
          image: DecorationImage(
              image: AssetImage(getAssetImage("splash_background.png")))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            getAssetLogo("logo.png"),
            width: 70,
            height: 70,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppConfig.appName,
            style: StyleConfig.fs30fwEBold(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 64,
          ),
          Text(
            AppLang.local(context).welcome_to_back,
            style: StyleConfig.fs22fwEBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLang.local(context)
                .energetically_streamline_one_to_one_web_readiness_before_extensive_meta_services,
            style: StyleConfig.fs12cLightfwNormal,
            textAlign: TextAlign.center,
          ),
         const SizedBox(height: 32,),
          Row(
            children: [
              Button(
                shape: StyleConfig.buttonRadius(5),
               minWidth: getWidth(context) * 0.42,
                color: ThemeConfig.accentColor,
                padding: EdgeInsets.symmetric(
                    horizontal: StyleConfig.padding14,
                    vertical: StyleConfig.padding14),
                child: Text(
                  AppLang.local(context).login,
                  style: StyleConfig.fs14cWhitefwNormal,
                ),
                onPressed: (){
                  MakeRoute.go(context, const Login());
                },
              ),
              Spacer(),
              Button(
                shape: StyleConfig.buttonRadius(5),

                minWidth: getWidth(context) * 0.42,
                color: ThemeConfig.secondaryColor,
                padding: EdgeInsets.symmetric(
                    horizontal: StyleConfig.padding14,
                    vertical: StyleConfig.padding14),
                onPressed: (){
                  MakeRoute.go(context, Registration());
                },
                child: Text(
                  AppLang.local(context).register,
                  style: StyleConfig.fs14cWhitefwNormal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
