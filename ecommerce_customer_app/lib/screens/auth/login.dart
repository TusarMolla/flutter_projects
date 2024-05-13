import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/auth_ui.dart';
import 'package:grostore/custom_ui/input_decorations.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/auth/auth_presenter.dart';
import 'package:grostore/screens/auth/password_forget.dart';
import 'package:grostore/screens/auth/registration.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthPresenter>(context, listen: false).setContext(context);
    return AuthScreen.buildScreen(
        context, buildBody(context, getWidth(context))
    );
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
                AppLang.local(context).welcome_to_back,
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
                      controller: data.loginEmailController,
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
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLang.local(context).password,
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
                      controller: data.loginPasswordController,
                      autofocus: false,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecorations.basic(
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 18,
                            color: ThemeConfig.mediumGrey,
                          ),
                          hint_text: "• • • • • • • •"),
                    ),
                  ),
                  Button(
                    minWidth: 50,
                    padding: EdgeInsets.zero,
                    child: Text(
                      AppLang.local(context).forgot_password_q_ucf,
                      style: TextStyle(
                          color: ThemeConfig.blue,
                          fontStyle: FontStyle.italic),

                    ),
                    onPressed: (){
                      MakeRoute.go(context, PasswordForget());
                    },
                  )
                ],
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
                      AppLang.local(context).login,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      data.onPressedLogin();
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                        AppLang.local(context).not_a_member,
                        style:
                        TextStyle(color: ThemeConfig.fontColor, fontSize: 12),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Button(
                    minWidth: 20,
                    child: Text(
                      AppLang.local(context).register_now_ucf,
                      style: TextStyle(
                          color: ThemeConfig.accentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Registration();
                          }));
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
