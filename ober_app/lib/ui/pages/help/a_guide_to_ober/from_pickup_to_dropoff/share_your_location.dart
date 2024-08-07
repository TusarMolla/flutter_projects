import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class SharingYourLocation extends StatelessWidget {
  const SharingYourLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Sharing your location"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Riders can show their exact location to their drivers by sharing their location. This feature helps your driver locate you as you make your way toward the pickup location.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("How it works",style:StyleConfig.fs24fwBold,),
            Text("When your driver arrives at the pickup spot, they'll see an extra icon on their map indicating where you are. Once your trip begins, your driver will no longer be able to see your location.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Turn location sharing on or off",style:StyleConfig.fs24fwBold,),
            Text('You can switch the feature on/off by using the toggle in the bottom right of the map screen.\nYou can also turn it on or off from Settings:\n1. From the main screen, select "Account"> "Settings" > "Privacy" > "Location."\n2. Select the "Share location with your driver" toggle to turn it on or off.',style: StyleConfig.fs14,),

          ],
        ),
      ),
    );
  }
}
