
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/auth_bloc.dart';
import 'package:ober_app/config/app_config.dart';
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
import 'package:ober_app/ui/pages/common_web_view.dart';


class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  AuthView(child:SafeArea(
      child: BlocBuilder<AuthBloc,AuthState>(
        builder: (context,state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                ImageView.circleContainer(assetUrl: getAssetLogo("logo.png"), height: 150, width: 150,color: ThemeConfig.accentColor),
                SizedBox(height: 20,),
                Text("Register with Ober",style: StyleConfig.fs24fwBold,),
                SizedBox(height: 30,),
                TextField(
                  controller: state.regUserNameController,
                  decoration:InputDecorations.round(prefix: Icons.account_circle_sharp,hint: "jhon"),),
                SizedBox(height: 10,),
                 TextField(
                   controller: state.regEmailController,
                   decoration:InputDecorations.round(prefix: Icons.email_outlined,hint: "jhone@example.com"),),
                SizedBox(height: 10,),

                TextField(
                  controller: state.regPasswordController,
                  keyboardAppearance:Brightness.dark ,
                  obscureText: true,
                  decoration:InputDecorations.round(prefix: Icons.lock_outline_rounded,hint: "••••••••"),
                ),
                SizedBox(height: 10,),

                TextField(
                  controller: state.regConfirmPasswordController,
                  keyboardAppearance:Brightness.dark ,
                  obscureText: true,
                  decoration:InputDecorations.round(prefix: Icons.lock_reset,hint: "••••••••"),
                ),

                SizedBox(height: 14,),

                Row(
                  children: [
                    Checkbox(

                        value: state.isAgree, onChanged: (newValue){
                      context.read<AuthBloc>().add(PrivacyAgree(newValue??false));
                    }),
                    InkWell(
                        onTap: (){
                          Uri uri = Uri.parse(AppConfig.baseUrl+"/privacy-policy-page");
                          SEORoute.go(context, CommonWebView(uri: uri));
                        },child: Text(getLocal(context).i_agree_with_terms_condition,style: StyleConfig.fs14.copyWith(decoration:  TextDecoration.underline,decorationStyle:TextDecorationStyle.wavy,decorationColor: themeTxtColor),)),
                  ],
                ),
                SizedBox(height: 14,),
                Buttons.round(

                    onPress:state.isAgree? (){
                  context.read<AuthBloc>().add(OnPressSignUp(context));
                }:null, child: Text("Registration",style: StyleConfig.fs14cWhite,)),

                SizedBox(height: 14,),
                Text("OR",style: StyleConfig.fs14,),
                SizedBox(height: 14,),
                Buttons.round(onPress: (){
                  Navigator.pop(context);
                }, child: Text("Login",style: StyleConfig.fs14cWhite),bColor: ThemeConfig.secondaryColor)
              ],
            ),
          );
        }
      ),
    ));
  }
}
