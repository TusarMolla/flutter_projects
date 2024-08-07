import 'package:flutter/material.dart';
import 'package:ober_app/custom_models/dropdown_model.dart';
import 'package:ober_app/config/theme_config.dart';

class SettingState {
  static final languages = [
    DropDownDataModel("en", "English"),
    DropDownDataModel("is", "Iceland"),
  ];

  DropDownDataModel selectedLang ;
  ThemeMode mode;
  Color themeContainerBgColor ;

  SettingState({required this.selectedLang,required this.mode,required this.themeContainerBgColor});

  SettingState.init():selectedLang = languages.first,
        mode = ThemeMode.dark,
  themeContainerBgColor = ThemeConfig.extraDarkGrey
  ;
  update(SettingState state){
    return SettingState(selectedLang: state.selectedLang,mode: state.mode,themeContainerBgColor:state.themeContainerBgColor);
  }

}