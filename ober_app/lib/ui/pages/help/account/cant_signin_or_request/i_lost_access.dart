import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/helpers/main_helper.dart';



class ILostAccess extends StatelessWidget {
  const ILostAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SeoAppbar.build(title: "I lost access to my phone number"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("If you can't sign in to an existing account because you no longer have access to the phone number or email address associated with the account, fill out the form below and we'll be in touch to help.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("The following information is required to keep your account secure",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Row(
              children: [
                Flexible(
                    flex: 10,
                    child: Text("I need to update the phone number on my account",style: StyleConfig.fs14,)),
                Flexible(
                    flex: 2,child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: ThemeConfig.accentColor,
                    value: true, onChanged: (value){},

                ))
              ],
            ),
            SizedBox(height: 14,),
            Row(
              children: [
                Flexible(
                    flex: 10,
                    child: Text("I need to update the email address on my account",style: StyleConfig.fs14,)),
                Flexible(
                    flex: 2,child: Switch(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: ThemeConfig.accentColor,
                    value: true, onChanged: (value){},

                ))
              ],
            ),
            SizedBox(height: 14,),
            SeoForms.textField(title: "First and last name", controller: TextEditingController(),),
            SizedBox(height: 14,),
            SeoForms.textField(title: "New phone or email address", controller: TextEditingController(),),
            SizedBox(height: 14,),
            SeoForms.textField(title: "Current phone number on the account", controller: TextEditingController(),),
            SizedBox(height: 14,),
            SeoForms.textField(title: "Current email address on the account", controller: TextEditingController(),),
            SizedBox(height: 14,),
            SeoForms.textField(title: "First 6 digits of a credit/debit card on file", controller: TextEditingController(),),
            SizedBox(height: 14,),

            Text("Screenshot of your new phone number from Device setting"),
            SizedBox(height: 10,),
            Container(
              height: 100,
              alignment: Alignment.center,
              decoration: Decorations.round(radius: 0,),
              child: Icon(Icons.camera_alt),
            ),
            SizedBox(height: 14,),
            Buttons.round(onPress: (){}, child: Text("Submit",style: StyleConfig.fs18.copyWith(color: themeBoxColor),),bColor: themeTxtColor,radius: 10,)

          ],
        ),
      ),
    );
  }
}
