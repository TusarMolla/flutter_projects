
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/auth_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/auth_events.dart';
import 'package:ober_app/states/auth_state.dart';



class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Update Password"),
      body: BlocBuilder<AuthBloc,AuthState>(
        builder: (context,state) {
          return Padding(
            padding: const EdgeInsets.all(StyleConfig.padding),
            child: Column(
              children: [
                SeoForms.passwordField(title: "Old password", controller: state.updatePassOldController,),
                SizedBox(height: 10,),
                SeoForms.passwordField(title: "New password", controller: state.updatePassNewController),
                SizedBox(height: 10,),
                SeoForms.passwordField(title: "Confirm password", controller: state.updatePassConfirmController),
                SizedBox(height: 14,),
                Buttons.round(onPress: (){
                  context.read<AuthBloc>().add(OnUpdatePassword(context));
                }, child: Text("Update"))
              ],
            ),
          );
        }
      ),
    );
  }
}
