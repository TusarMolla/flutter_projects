var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@" + this_year; //this shows in the splash screen
  static String app_name =
      "seller app"; //this shows in the splash screen
  static String purchase_code =
      ""; //enter your purchase code for the app from
  static String system_key =
      ""; //enter your purchase code for the app from 

  //configure this
  // static const bool HTTPS = false;
  static const bool HTTPS = true;

  //Default language config
  static String default_language = "en";
  static String mobile_app_code = "en";
  static bool app_language_rtl = false;


  static const DOMAIN_PATH =
      "";

  //do not configure these below
  static const String API_ENDPATH = "api/v2";
  static const String PUBLIC_FOLDER = "public";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String SELLER_PREFIX = "seller";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
  static const String BASE_URL_WITH_PREFIX = "${BASE_URL}/${SELLER_PREFIX}";
}
