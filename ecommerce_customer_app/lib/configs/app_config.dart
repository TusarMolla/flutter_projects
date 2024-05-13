

class AppConfig{
  static String appName ="Customer APp";//Rename it with your app name

  static const bool https = true;//Make it true if your domain support https otherwise make it false


 // static const domain = "192.168.31.237/laravel"; //If you want to connect with local host provide your ip address instead localhost.
 static const domain = "domain.com"; //If you want to connect with your server replace it with your domain name

  //Don't try change below values
  static const String apiEndPath = "api";
  static const String protocol = https ? "https://" : "http://";
  static const String baseUrl = protocol+ domain;
  static const String apiUrl = "$baseUrl/$apiEndPath";
}