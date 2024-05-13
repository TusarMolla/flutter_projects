import 'package:grostore/models/common/user_info.dart';
import 'package:grostore/models/currency_response.dart';
import 'package:grostore/models/setting_response.dart';

class SystemData {
  // static CurrencyInfo? systemCurrency;
  static SettingResponse? settings;
  static bool isLogIn = false;
  static UserInfo userInfo =
      UserInfo(name: "", email: "", phone: "", balance: "", avatar: "");
  static String couponCode = "";
}
