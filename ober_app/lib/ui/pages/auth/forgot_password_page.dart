import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/auth_bloc.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/auth_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/states/auth_state.dart';
import 'package:ober_app/ui/models/auth.dart';



class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
                  SeoForms.textField(title: getLocal(context).email, controller: state.forgotPEmail),
                  SizedBox(height: 14,),
                  Buttons.round(onPress: (){
                    context.read<AuthBloc>().add(ForgotPassword(context));
                  }, child: Text(getLocal(context).send_otp))
                ],
              ),
            ),
          );
        }
      ) ,
    );
  }
}
