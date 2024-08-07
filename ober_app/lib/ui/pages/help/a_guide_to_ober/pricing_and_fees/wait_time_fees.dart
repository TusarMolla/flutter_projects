import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class WaitTimeFees extends StatelessWidget {
  const WaitTimeFees({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Wait time fees"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("""
If your trip is canceled and you are charged a cancellation fee, you will not be charged for wait time.
Wait time fees and thresholds vary by location. In certain markets, additional wait-time charges may apply to your trip depending on how busy it is. For more details on the rates and thresholds.
The wait time fee grace period and the commencement of the no-show window start at the time of a driver's arrival at a pick-up location. A driver's arrival time is based on technology that uses GPS coordinates, which does not always perfectly correspond to real world coordinates.
            """,style: StyleConfig.fs14,),


          ],
        ),
      ),
    );
  }
}
