import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class AddingSavePlaces extends StatelessWidget {
  const AddingSavePlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Adding saved places on Android/iOS"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("You can delete ",style: StyleConfig.fs18,),
            Text("You can add places that are frequent destinations, like work or home, within th app.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("To save your home or work address",style: StyleConfig.fs18,),
            Text("1. From the main screen select Account",style: StyleConfig.fs14,),
            Text("2. Tap Add home or Add work",style: StyleConfig.fs14,),
            Text("3. Enter your home or work address",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}
