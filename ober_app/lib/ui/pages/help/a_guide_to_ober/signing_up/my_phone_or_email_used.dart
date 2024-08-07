import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/tickets/create_ticket.dart';

class MyPhoneEmailAlreadyUsed extends StatelessWidget {
const MyPhoneEmailAlreadyUsed({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: getLocal(context).my_phone_or_email_is_already_in_use),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getLocal(context).help_guide_to_ober_signing_phone_or_email_used,style: StyleConfig.fs14,),
            SizedBox(height: 10,),
            Buttons.gotoTicket(context),

          ],
        ),
      ),
    );
  }
}
