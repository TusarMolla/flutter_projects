import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';


class IWouldLikeToKnowRating extends StatelessWidget {
  const IWouldLikeToKnowRating({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "I would like to know my rating"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("You can delete ",style: StyleConfig.fs18,),
            Text("After each trip, riders and drivers are given the opportunity to rating one another base on their trip experience.",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("The rating system work to make suer that the most respectful riders and driver are using Ober. Ratings are always reported as averages, and neither riders nor drivers will see the individual rating left for a particular trip.",style: StyleConfig.fs14,),
            SizedBox(height: 18,),
            Text("To see your rating:",style: StyleConfig.fs18,),
            Text("1. Open the app and touch the menu",style: StyleConfig.fs14,),
            Text("2. Your rating is the number displayed under your name.",style: StyleConfig.fs14,),
            Text("You need to take 2 trip before you'll have a rider rating. if you don't see a rating, it is probably because you haven't taken enough trip.",style: StyleConfig.fs14,),
          ],
        ),
      ),
    );
  }
}
