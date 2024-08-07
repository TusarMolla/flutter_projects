import 'package:flutter/material.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/auth.dart';
import 'package:ober_app/helpers/device_info.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/shared_value_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/ui/pages/auth/login_page.dart';
import 'package:ober_app/ui/pages/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    access_token.load().then((value) {
      Auth.check().then((value) {
        Future.delayed(Duration(seconds: 2), () {
          if (!SystemData.isLogedIn) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
          }else{
            SEORoute.goAndRemoveAll(context, MainPage());
          }
        });
      });
    });
    //
    // Future.delayed(Duration(seconds: 3)).then((value) {
    //   Navigator.pushAndRemoveUntil(context,
    //       MaterialPageRoute(builder: (context) => MainPage()), (route) => false);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).brightness);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            /*image: DecorationImage(image: AssetImage(getAssetImage("background.png")),
                  opacity: 0.12,
                  fit: BoxFit.cover
                // colorFilter: ColorFilter.mode(Colors.red.withOpacity(0.5), BlendMode.clear)
              )*/
            ),
        width: DeviceInfo.width,
        height: DeviceInfo.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              // decoration: BoxDecorations.shadow(radius: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    getAssetLogo("logo.png"),
                    color: isDarkMode ? Colors.white : null,
                    // width: 150,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    getAssetGif("car_moving.gif"),
                    // width: 150,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
