import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class RequestingASpecificDriver extends StatelessWidget {
  const RequestingASpecificDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Requesting a specific driver"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("""
The app cannot match you with a specific driver.
When you request a ride, your app sends your request to nearby drivers to pick you up at your pickup location.""",style: StyleConfig.fs14,),

          ],
        ),
      ),
    );
  }
}
