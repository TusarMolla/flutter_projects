import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/helpers/main_helper.dart';



class HowAreFaresCalculated extends StatelessWidget {
  const HowAreFaresCalculated({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: getLocal(context).how_are_fares_calculated),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getLocal(context).how_are_fares_calculated_details,style: StyleConfig.fs14,),
            SizedBox(height: 14,),

          ],
        ),
      ),
    );
  }
}
