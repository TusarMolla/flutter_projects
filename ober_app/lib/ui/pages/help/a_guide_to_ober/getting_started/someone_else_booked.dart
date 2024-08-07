import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class SomeoneElseBooked extends StatelessWidget {
  const SomeoneElseBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Someone else booked me a ride"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Why did I get a notification for a ride I didn't book?",style:StyleConfig.fs24fwBold,),
            Text("If you received a text message that you have a ride with Uber on the way, someone may have scheduled a ride for you. Follow the instructions in the text message to view your pickup details.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Types of rides that can be requested by others",style:StyleConfig.fs24fwBold,),
            Text("You can have three types of trips requested for you:\n• Rides requested by an Uber for Business organization\n• Rides requested by public transit organizations\n• Rides booked by friends or family",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Rides requested by an Uber for Business organization",style:StyleConfig.fs24fwBold,),
            Text("When an Uber for Business organization requests a ride for you, you'll receive either:",style: StyleConfig.fs14,),
            Text("• A text message to your mobile phone \n•An automated call to your mobile or landline phone number\n• An Uber app notification",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Rides requested by public transit organizations",style:StyleConfig.fs24fwBold,),
            Text("Public transit organizations can book a shuttle, UberX, or Uber Pool for you. The Uber app provides real-time transit information. Transit information, prices, routes, and schedules are provided by a third party, and Uber cannot guarantee their accuracy.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Rides booked by friends or family",style:StyleConfig.fs24fwBold,),
            Text("A friend or family member can request a ride for you even if you are in a different location. If you don't have an Uber account, you'll receive a message with instructions for your trip along with your driver and vehicle information. If you have an Uber account, you'll receive an app notification with:\n•The driver's details \n•The vehicle's details\n• Real-time tracking for your ride",style: StyleConfig.fs14,),
            SizedBox(height: 14,),

          ],
        ),
      ),
    );
  }
}
