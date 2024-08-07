import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/events/setting_events.dart';
import 'package:ober_app/helpers/shared_value_helper.dart';
import 'package:ober_app/states/setting_state.dart';

class SettingBloc extends Bloc<SettingEvents,SettingState>{


  SettingBloc():super(SettingState.init()){
    on<ChangeLang>((event, emit)async {
      _changeLang(event);
      emit(state.update(state));
    });

    on<ChangeMode>((event, emit){
      _changeMode(event.mode);
      emit(state.update(state));
    });
  }

  _changeLang(ChangeLang event){
    langCode.$ = event.locale.key;
    langCode.save();
    state.selectedLang = event.locale;
  }

  _changeMode(ThemeMode mode){
    state.mode = mode;
    state.themeContainerBgColor = state.mode == ThemeMode.dark ? ThemeConfig.extraDarkGrey:ThemeConfig.lightGrey;
    themeMode.$ = mode.index;
    themeMode.save();
  }
}