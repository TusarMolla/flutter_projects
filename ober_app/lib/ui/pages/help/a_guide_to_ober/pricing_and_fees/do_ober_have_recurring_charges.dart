import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class DoOberHaveRecurringCharges extends StatelessWidget {
  const DoOberHaveRecurringCharges({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Does Ober have recurring charges"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("""Good news! There are no recurring charges or membership fees for using Uber. You are only charged for the rides you take.""",style: StyleConfig.fs14,),

          ],
        ),
      ),
    );
  }
}
