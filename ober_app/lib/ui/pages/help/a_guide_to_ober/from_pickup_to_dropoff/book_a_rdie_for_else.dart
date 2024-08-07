import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class BookARideForElse extends StatelessWidget {
  const BookARideForElse({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Book a ride for someone else"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ober Bounce rides let you request trips for friends and family in a different location.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("To request a ride for someone else:",style:StyleConfig.fs24fwBold,),
            Text('1. Tap “Where to?" and enter your friend\'s pickup location.\n2. Tap "Confirm pickup."\n3. Enter your friend\'s contact details: Either select their contact information from the contact picker or type in their mobile number.\n4. Select your friend. Make sure they have an arrow on their icon.\n5. Tap "Confirm Rider" and "Next."',style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text('If you didn\'t see the option to select "Someone else," try this instead:',style:StyleConfig.fs24fwBold,),
            Text('1. Tap the "Where to?" box.\n2. Tap the dropdown icon next to your name. 3. Continue through the rest of the steps described above.\nOnce the trip is accepted, the rider will get text messages from Ober with detailed instructions about the ride.',style: StyleConfig.fs14,),


          ],
        ),
      ),
    );
  }
}
