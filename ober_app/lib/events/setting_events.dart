import 'package:flutter/material.dart';
import 'package:ober_app/custom_models/dropdown_model.dart';
import 'package:ober_app/events/seo_event.dart';


class SettingEvents extends SeoEvent{

}


class ChangeLang extends SettingEvents{
  DropDownDataModel locale;

  ChangeLang(this.locale);
}

class ChangeMode extends SettingEvents{
  ThemeMode mode;

  ChangeMode(this.mode);
}