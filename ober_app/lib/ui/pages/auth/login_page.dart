
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/auth_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/images.dart';
import 'package:ober_app/custom_widgets/input_decorations.dart';
import 'package:ober_app/events/auth_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/states/auth_state.dart';
import 'package:ober_app/ui/models/auth.dart';
import 'package:ober_app/ui/pages/auth/forgot_password_page.dart';
import 'package:ober_app/ui/pages/auth/registration_page.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  AuthView(child:SafeArea(
      child: BlocBuilder<AuthBloc,AuthState>(
        builder: (context,store) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                ImageView.circleContainer(assetUrl: getAssetLogo("logo.png"), height: 150, width: 150,color: ThemeConfig.accentColor),
                SizedBox(height: 20,),
                Text("Login with Ober",style: StyleConfig.fs24fwBold,),
                SizedBox(height: 30,),
                TextField(
                  controller: store.loginEmailController,
                  decoration:InputDecorations.round(prefix: Icons.email_outlined,hint: "jhone@example.com"),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: store.loginPasswordController,
                  keyboardAppearance:Brightness.dark ,
                  obscureText: true,
                  decoration:InputDecorations.round(prefix: Icons.lock_outline_rounded,hint: "••••••••"),
                ),
                SizedBox(height: 14,),
                Buttons.round(onPress: (){
                  context.read<AuthBloc>().add(OnPressLogin(context));
                }, child: Text("Login",style: StyleConfig.fs14cWhite,)),

                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      SEORoute.go(context, ForgotPasswordPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(getLocal(context).forgot_password),
                    ),
                  ),
                ),
                SizedBox(height: 14,),
                Text("OR",style: StyleConfig.fs14,),
                SizedBox(height: 14,),
                Buttons.round(onPress: (){

                  SEORoute.go(context, RegistrationPage());

                }, child: Text("Registration",style: StyleConfig.fs14cWhite),bColor: ThemeConfig.secondaryColor)
              ],
            ),
          );
        }
      ),
    ));
  }
}

