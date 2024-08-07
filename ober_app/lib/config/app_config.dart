

class AppConfig{
  static String appName ="Uber";//Rename it with your app name
  static String copyRight ="Uber";//Rename it with your app name

  static const bool https = false;//Make it true if your domain support https otherwise make it false

 static const domain = ""; //If you want to connect with your server replace it with your domain name

 // static const domain = "tlt.devseoebd.com"; //If you want to connect with your server replace it with your domain name

  //Don't try change below values
  static const String apiEndPath = "api";
  static const String protocol = https ? "https://" : "http://";
  static const String baseUrl = protocol+ domain;
  static const String apiUrl = "$baseUrl/$apiEndPath";
  static const String public_assets = "$baseUrl/storage";
  static const String support_assets = "$baseUrl/assets/suppot";
  //For google map apis
  static const googleMapApiUrl = "https://maps.googleapis.com/maps/api";
  static const googleMapAPIKey="";
  static const publishable="";


  static const String pusherApiKey = "";
  static const String pusherCluster = "";
  static const String tripAcceptChannel = "";
  static const String driverLocationChannel = "";
  static const String tripCancelChannel = "";
  static const String tripStartChannel = "";
  static const String tripCompleteChannel = "";

  static const String rapydApi = "https://sandboxapi.rapyd.net";
  static const String rapydAccessKey = "";
  static const String rapydSecretKey = "";


  static const int reRequestTime = 15;//this time value will be count in second

  // static const String rapyd = "trip-complete";
  // static const String rapyd = "trip-complete";

}