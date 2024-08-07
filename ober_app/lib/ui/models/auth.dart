



import 'package:flutter/material.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/device_info.dart';
import 'package:ober_app/helpers/main_helper.dart';

class AuthView extends StatelessWidget {
   AuthView({super.key,required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: DeviceInfo.height,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
                child: Image.asset(getAssetImage("auth_back.png")),width: DeviceInfo.width,),

            Positioned(
              bottom: 0,
              left: 0,

              child: Container(
                width: DeviceInfo.width,
                height: 200,
                decoration: BoxDecoration(
                  // color: ThemeConfig.accentColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(100))
                ),
              child: Container(
                // color: Colors.red,
                child: Stack(

                  children: [
                    Positioned(
                      top: -40,
                        left: -80,
                        // right: 0,
                        // left: -5,
                        child: Image.asset(getAssetImage("car.png"),height: 300,width: 300,),


                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: DeviceInfo.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                                flex: 1,
                                child: Image.asset(getAssetImage("honda.png",))),
                            Flexible(
                                flex: 1,child: SizedBox.shrink(),),
                            Flexible(
                                flex: 1,child: Image.asset(getAssetImage("motorcycle.png",))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),),),
            SingleChildScrollView(child: Center(child: child)),
          ],
        ),
      ),
    );
  }
}
