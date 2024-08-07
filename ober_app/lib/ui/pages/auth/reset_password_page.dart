import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/auth_bloc.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/auth_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/states/auth_state.dart';
import 'package:ober_app/ui/models/auth.dart';


class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
  return  AuthView(
      child:BlocBuilder<AuthBloc,AuthState>(
          builder: (context,state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0,left: 14,right: 14),
                child: Column(
                  children: [
                    SeoForms.textField(title: getLocal(context).otp, controller: state.forgotPOTP,hint: "58001"),
                    SizedBox(height: 14,),
                    SeoForms.passwordField(title: getLocal(context).new_password, controller: state.forgotPNewPassword,),
                    SizedBox(height: 14,),
                    SeoForms.passwordField(title: getLocal(context).confirm_password, controller: state.forgotPConfirmPassword),
                    SizedBox(height: 14,),
                    Buttons.round(onPress: (){
                      context.read<AuthBloc>().add(ResetPassword(context));
                    }, child: Text(getLocal(context).send))
                  ],
                ),
              ),
            );
          }
      ) ,
    );
  }
}
