import 'package:flutter/material.dart';
import 'package:shared_value/shared_value.dart';

final SharedValue<String> access_token = SharedValue(
  value: "", // initial value
  key: "access_token",
  autosave: true// disk storage key for shared_preferences
);

final SharedValue<String> langCode = SharedValue(
  value: "en", // initial value
  key: "lang_code",
  autosave: true// disk storage key for shared_preferences
);


final SharedValue<int> themeMode = SharedValue(
    value: ThemeMode.dark.index, // initial value
    key: "theme_mode",
    autosave: true// disk storage key for shared_preferences
);
