
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/blocs/setting_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/shared_value_helper.dart';
import 'package:ober_app/main.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


bool isNumeric(String str) {
  RegExp _numeric = RegExp(r'^-?[0-9]+$');
  return _numeric.hasMatch(str);
}

bool isEmail(String input) {
  return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
      .hasMatch(input);
}

getAssetImage(String img) {
  return "assets/images/$img";
}

getAssetIcon(String icon) {
  return "assets/icons/$icon";
}

getAssetLogo(String logo) {
  return "assets/logos/$logo";
}

getAssetGif(String logo) {
  return "assets/gif/$logo";
}

getAssetFlag(String name) {
  return "assets/flags/$name";
}


bool get isDarkMode => globalState.currentState!.context.read<SettingBloc>().state.mode == ThemeMode.dark;

Color get themeColor =>
    isDarkMode ? ThemeConfig.white : ThemeConfig.extraDarkGrey;

Color get backgroundTheme =>
    isDarkMode ? ThemeConfig.darkThemeColor : ThemeConfig.lightThemeColor;

Color get themeTxtColor =>
    isDarkMode ? ThemeConfig.white : ThemeConfig.fontColor;

Color get themeBoxColor =>
    isDarkMode ? ThemeConfig.extraDarkGrey : ThemeConfig.white;

Color get blackAndWhite => isDarkMode ? ThemeConfig.black : ThemeConfig.white;

Color get whiteAndBlack => isDarkMode ? ThemeConfig.white : ThemeConfig.black;


String get randomStr{
  var str = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var tmpList = str.split("");
  var tmpList2= tmpList..shuffle();
  return tmpList2.join();
}

Map<String, String> getCommonHeader() {
  return {
    "Accept": "application/json",
    "Content-Type": "application/json",
    // "App-Language": app_language.$,
    // "Stock-Location-Id":stock_location_id.$
  };
}

Map<String, String> get getAuthHeader => {
      "Authorization": "Bearer ${access_token.$}",
    };


refundStatus(status){
  String tmp = "Paid";
  if(status.toString()=="0"){
    tmp ="Pending";
  }else
  if(status.toString()=="1"){
    tmp ="Requested";
  }else
  if(status.toString()=="3"){
    tmp ="Cancel";
  }
  return tmp;

}

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

Future<LatLng> get getCurrentLocation async {
  var tmpData = await isPermissionGranted;
  if (!tmpData) {
    return Future.error('Location permissions are denied');
  }

  var tmpLocation = await Geolocator.getCurrentPosition();

  var tmp = LatLng(tmpLocation.latitude, tmpLocation.longitude);
  SystemData.userCurrentLocation = tmp;
  return tmp;
}

Future<bool> get isPermissionGranted => _checkPermission();

Future<bool> _checkPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return false;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return true;
}

 String priceWithSymbol(price)=>"USD $price";


List mapToListOfString(Map map) {
  List tmp = [];
  map.forEach((key, value) {
    if (value is Map) {
      mapToListOfString(value);
    } else if (value is List) {
      tmp.addAll(value);
    } else {
      tmp.add(value);
    }
  });
  return tmp;
}

String getApiPath(String path) {
  if (path.startsWith("/")) {
    return "${AppConfig.apiUrl}$path";
  }
  return "${AppConfig.apiUrl}/$path";
}


Future<XFile?> pickImage()async{
  final ImagePicker picker = ImagePicker();
// Pick an image.
  return await picker.pickImage(source: ImageSource.gallery);


}

String statusToString(var status){
  var tmp="Initiate";
  if(status.toString()=="0"){
    tmp="Initiate";
  }else if(status.toString()=="1"){
    tmp="Accepted";
  }else if(status.toString()=="2"){
    tmp="Completed";
  }else if(status.toString()=="3"){
    tmp="Canceled";
  }else if(status.toString()=="4"){
    tmp="Started ";
  }
  return tmp;
}
Color statusToColor(var status){
  var tmp=themeTxtColor;
  if(status.toString()=="0"){
    tmp=themeTxtColor;
  }else if(status.toString()=="1"){
    tmp=ThemeConfig.accentColor;
  }else if(status.toString()=="2"){
    tmp=ThemeConfig.green;
  }else if(status.toString()=="3"){
    tmp=ThemeConfig.red;
  }else if(status.toString()=="4"){
    tmp=Colors.yellow;
  }
  return tmp;
}

getUsername(BuildContext context)=>(context.read<OberAccountBloc>().state.usersData?.firstName?? "Mr.")+" " + (context.read<OberAccountBloc>().state.usersData?.lastName??"User");
getUserPhoto(BuildContext context)=>context.read<OberAccountBloc>().state.usersData?.image??"";

AppLocalizations getLocal(BuildContext context)=>AppLocalizations.of(context)!;
