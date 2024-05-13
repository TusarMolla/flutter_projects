import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/auth_ui.dart';
import 'package:grostore/custom_ui/input_decorations.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/auth/auth_presenter.dart';
import 'package:grostore/screens/auth/password_otp.dart';
import 'package:provider/provider.dart';


class PasswordForget extends StatefulWidget {
  @override
  _PasswordForgetState createState() => _PasswordForgetState();
}

class _PasswordForgetState extends State<PasswordForget> {
  @override
  Widget build(BuildContext context) {
    return AuthScreen.buildScreen(context, buildBody(getWidth(context), context));
  }

  Widget buildBody(double screenWidth, BuildContext context) {
    return Consumer<AuthPresenter>(builder: (context, data, child) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),

        width: screenWidth * (3 / 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: getWidth(context),
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLang.local(context).forgot_password_ucf,
                style: StyleConfig.fs24fwBold,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLang.local(context).email,
                style: TextStyle(
                    color: ThemeConfig.fontColor, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 36,
                    child: TextField(
                      controller: data.forgetEmailController,
                      autofocus: false,
                      decoration: InputDecorations.basic(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 18,
                            color: ThemeConfig.mediumGrey,
                          ),
                          hint_text: "user@example.com"),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                height: 45,
                child: Button.minSize(
                    width: getWidth(context),
                    height: 50,
                    color: ThemeConfig.accentColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Text(
                      AppLang.local(context).send,
                      style:const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      //data.onPressedLogin();
                      MakeRoute.go(context, PasswordOtp());

                    }),
              ),
            ),
          ],
        ),
      );
    });
  }
}
