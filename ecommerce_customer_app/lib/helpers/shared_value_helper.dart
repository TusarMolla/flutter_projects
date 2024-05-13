
import 'package:shared_value/shared_value.dart';

final SharedValue<bool> show_landing_page = SharedValue(
  value: true, // initial value
  key: "show_landing_page",
  autosave: true// disk storage key for shared_preferences
);

final SharedValue<String> access_token = SharedValue(
  value: "", // initial value
  key: "access_token",
  autosave: true// disk storage key for shared_preferences
);
final SharedValue<String> app_language = SharedValue(
  // initial value
  key: "app_mobile_language",
  value: "en",
  autosave: true
);

final SharedValue<bool> language_is_rtl = SharedValue(
  // initial value
  key: "language_is_rtl",
  value: false,
  autosave: true
);
final SharedValue<String> server_app_language = SharedValue(
  value: "en", // initial value
  key: "server_app_language",
  autosave: true// disk storage key for shared_preferences
);

final SharedValue<String> system_currency = SharedValue(
  key: "system_currency",
  value: '',
);
final SharedValue<String> stock_location_id = SharedValue(
  key: "stock_location_id",
  value: '',
  autosave: true,
);
