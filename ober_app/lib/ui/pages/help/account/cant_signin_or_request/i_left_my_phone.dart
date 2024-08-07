import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/helpers/main_helper.dart';




class ILeftMyPhone extends StatelessWidget {
  const ILeftMyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "I left my phone in a vehicle"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("If you left your phone in a vehicle and can't sign in to your account, fill out the form below to let us know. We know how to frustrating this can be and will do everything we can to help",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Did you someone else request the trip?",style: StyleConfig.fs18,),
            SizedBox(height: 8,),
            Text("If you left your phone in a vehicle on a trip that someone else requested, the person who requested the trip must report tha lost item in their own app:",style: StyleConfig.fs14,),
            SizedBox(height: 8,),
            Text("1. Tap “Account” and then “Account”.",style: StyleConfig.fs14,),
            Text("2. Select the trip on which you lost your phone.",style: StyleConfig.fs14,),
            Text("3. Tap “Find lost item” and then “Contact driver about a lost item”.",style: StyleConfig.fs14,),
            Text("4. The person who requested the trip can enter their phone number to call the driver and coordinate the return of your phone.",style: StyleConfig.fs14,),
            Text("5. If they can't contact the driver, go back to the “Find lost item” page and select “I couldn't reach my driver about a lost item”. They can fill out the form and we'll be in touch to help.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Did you request the trip on your account?",style: StyleConfig.fs18,),
            SizedBox(height: 8,),
            Text("Things to note when filling out the form below:",style: StyleConfig.fs14,),
            Text("1. For security reasons, we need to verify your identity and account to help",style: StyleConfig.fs14,),//“”
            Text("2. By giving us permission to share your number, you understand that we will share this phone number with your driver for this trip and the driver may contact you directly using this phone number. We are no responsible for the driver's use of the phone number you have agreed to share.",style: StyleConfig.fs14,),
            Text("1. To pay the driver for their time and effort returning your phone, your account may be charged a return fee(amount varies by location) once your phone is returned.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("While we do sincerely hope you get your item back soon, neither Ober nor drivers are responsible for any items left in a vehicle after a trip ends. We're here to help, but cannot guarantee that a driver has your item or can deliver it to you since they are independent contractors.",style: StyleConfig.fs14,),
            SizedBox(height: 18,),
            SeoForms.textField(title: "First Name", controller: TextEditingController(),hint: "Your account name"),
            SizedBox(height: 18,),
            SeoForms.textField(title: "Last Name", controller: TextEditingController(),hint: "Your account name"),
            SizedBox(height: 18,),
            SeoForms.textField(title: "Email on your account", controller: TextEditingController(),hint: "Your account name"),

            SizedBox(height: 18,),
            SeoForms.textField(title: "Phone number on your account", controller: TextEditingController(),hint: "Your account name"),
            SizedBox(height: 18,),
            SeoForms.textField(title: "Phone number we can contact you at", controller: TextEditingController(),hint: "Your account name"),
            SizedBox(height: 18,),
            SeoForms.textField(title: "Do you have permission to share this number with the driver?", controller: TextEditingController(),hint: "Your account name"),


            SizedBox(height: 18,),
            SeoForms.textField(title: "Describe 2 recent trips", controller: TextEditingController(),hint: "Your account name"),


            SizedBox(height: 18,),
            SeoForms.textField(title: "Describe the lost phone", controller: TextEditingController(),hint: "Your account name"),
SizedBox(height: 18,),
            Buttons.round(onPress: (){}, child: Text("Submit",style: StyleConfig.fs18.copyWith(color: themeBoxColor),),bColor: themeTxtColor,radius: 10,)


          ],
        ),
      ),
    );
  }
}
//“”