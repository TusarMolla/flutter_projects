
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class DeleteMyOberAccount extends StatelessWidget {
  const DeleteMyOberAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Delete my Ober account"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("You can delete ",style: StyleConfig.fs18,),
            Text("You can delete your account from the app.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("When you begin, we'll ask you to verify your identity using a tmporary verification code. This may require you to have a phone number attached to your account.",style: StyleConfig.fs14,),
            SizedBox(height: 18,),
            Text("Delete your account",style: StyleConfig.fs18,),
            Text("1. Go to Account, then Setting",style: StyleConfig.fs14,),
            Text("2. Select Privacy",style: StyleConfig.fs14,),
            Text("3. Scroll down and tap Account Deletion.",style: StyleConfig.fs14,),
            Text("3. Follow the remaining steps in the app to complete the process.",style: StyleConfig.fs14,),
            SizedBox(height: 18,),
            Text("Notes on deleting your account",style: StyleConfig.fs18,),

            Text("After completing either process above, your account will be immediately deactivated and then permanently deleted after 30 days. Any unused credits, promotions, or rewards will be removed. if you sign back into your account during this period, your account will be restored.",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}
