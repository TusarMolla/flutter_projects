
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/setting_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/events/setting_events.dart';
import 'package:ober_app/states/setting_state.dart';



class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Appearance"),
      body: BlocBuilder<SettingBloc,SettingState>(
        builder: (context,state) {
          return Padding(
            padding: const EdgeInsets.all(StyleConfig.padding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 10,
                        child: Text("Dark Mode",style: StyleConfig.fs14,)),
                    Flexible(
                        flex: 2,child: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: ThemeConfig.accentColor,
                      value: state.mode==ThemeMode.dark,
                      onChanged: (value){
                        ThemeMode mode = ThemeMode.light;
                        if(value){
                           mode = ThemeMode.dark;
                        }
                          context.read<SettingBloc>().add(ChangeMode(mode));
                    },

                    ))
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
