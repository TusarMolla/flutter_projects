import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';



class AmICahargedForCancelling extends StatelessWidget {
  const AmICahargedForCancelling({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: getLocal(context).am_i_charged_for_cancelling_a_trip),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getLocal(context).am_i_charged_for_cancelling_a_trip_details,style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            /*Text("Cancelling non-OberX Share trips",style: StyleConfig.fs24fwBold,),
            Text("""
You may be charged a cancellation fee if:
• You cancel a few minutes after a driver accepts the trip. The specific amount of time depends on your location.
• Your driver cancels after waiting a few minutes at your pickup location. The specific amount of time depends on your location.
            """,style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("OberX Share cancellation fees",style: StyleConfig.fs24fwBold,),
            Text("""
You may be charged a cancellation fee:
• If you cancel a few minutes after your driver accepts the trip. The specific amount of time depends on your location.
• If your driver cancels after waiting a few minutes at the pickup location. The specific amount of time depends on your location.
            """,style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("Waived cancellation fees",style: StyleConfig.fs24fwBold,),
            Text("""
You won't be charged a cancellation fee if:
• Your driver took much longer than expected to arrive.
• Uber detects that your driver isn't making much progress to your pickup location.
If you believe you were charged a cancellation fee in error, let us know in the Review my cancellation fee form. This might happen if your driver canceled instead of ending the trip, or if they cancelled because they were too far away from your pickup location.
            """,style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("",style: StyleConfig.fs24fwBold,),
            Text("",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("",style: StyleConfig.fs24fwBold,),
            Text("",style: StyleConfig.fs14,),
            SizedBox(height: 14,),*/
          ],
        ),
      ),
    );
  }
}
