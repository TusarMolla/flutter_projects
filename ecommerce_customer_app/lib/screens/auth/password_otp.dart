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
import 'package:grostore/presenters/auth/auth_presenter.dart';
import 'package:provider/provider.dart';

class PasswordOtp extends StatefulWidget {
  PasswordOtp({super.key, this.verify_by = "email", this.email_or_code});
   String? verify_by;
   String? email_or_code;

  @override
  _PasswordOtpState createState() => _PasswordOtpState();
}

class _PasswordOtpState extends State<PasswordOtp> {



  @override
  Widget build(BuildContext context) {
    return AuthScreen.buildScreen(
        context, buildBody(context, getWidth(context)));
  }


  Widget buildBody(BuildContext context, double screenWidth) {
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
                AppLang.local(context).reset_password_ucf,
                style: StyleConfig.fs24fwBold,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLang.local(context).otp_all_cap,
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
                      controller: data.otpCodeController,
                      autofocus: false,
                      decoration: InputDecorations.basic(
                          prefixIcon: Icon(
                            Icons.abc,
                            size: 18,
                            color: ThemeConfig.fontColor,
                          ),
                          hint_text: "XXXXX"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLang.local(context).new_password_ucf,
                style: TextStyle(
                    color: ThemeConfig.fontColor, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 36,
                child: TextField(
                  controller: data.otpPasswordController,
                  autofocus: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecorations.basic(
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 18,
                        color: ThemeConfig.fontColor,
                      ),
                      hint_text: "• • • • • • • •"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLang.local(context).confirm_password_ucf,
                style: TextStyle(
                    color: ThemeConfig.fontColor, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 36,
                child: TextField(
                  controller: data.otpPasswordConfirmController,
                  autofocus: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecorations.basic(
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 18,
                        color: ThemeConfig.fontColor,
                      ),
                      hint_text: "• • • • • • • •"),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                height: 45,
                child: Button.minSize(
                    width: getWidth(context),
                    height: 50,
                    color: ThemeConfig.accentColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Text(
                      AppLang.local(context).send,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      data.onPressConfirm();
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    minWidth: 20,
                    child: Text(
                      AppLang.local(context).resend_otp_all_cap,
                      style: TextStyle(
                          color: ThemeConfig.accentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //       return Registration();
                      //     }));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
