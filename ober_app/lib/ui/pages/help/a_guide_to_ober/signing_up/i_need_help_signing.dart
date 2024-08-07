import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/helpers/main_helper.dart';



class INeedHelpSigning extends StatelessWidget {
  const INeedHelpSigning({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: getLocal(context).i_need_help_signing_up_for_a_rider_account),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getLocal(context).i_need_help_signing_up_for_a_rider_account_details,style: StyleConfig.fs14,),
            SizedBox(height: 18,),
            Buttons.gotoTicket(context)

          ],
        ),
      ),
    );
  }
}

