
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class UpdateMyProfile extends StatelessWidget {
  const UpdateMyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Update my profile"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("To update your name, email, phone number, or password",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("1. Open the app menu and tap Setting.",style: StyleConfig.fs14,),
            Text("2. Tap the bar that displays your name, phone number and email.",style: StyleConfig.fs14,),
            Text("3. Tap the detail you want to change and enter the updated information.",style: StyleConfig.fs14,),
            Text("1. Make your updates and click Save.",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}
