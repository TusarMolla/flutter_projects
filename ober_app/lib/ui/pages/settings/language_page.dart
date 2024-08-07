
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/setting_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/setting_events.dart';
import 'package:ober_app/states/setting_state.dart';


class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Language"),
      body: BlocBuilder<SettingBloc,SettingState>(
        builder: (context,state) {
          return Padding(
            padding: const EdgeInsets.all(StyleConfig.padding),
            child: Column(
              children: [
                SeoForms.dropdown(title: "Language", data: SettingState.languages, selectedValue: state.selectedLang, context: context, onSelected: (value){
                  if(value !=null){
                    context.read<SettingBloc>().add(ChangeLang(value));
                  }
                },isDataInit: true)
              ],
            ),
          );
        }
      ),
    );
  }
}
