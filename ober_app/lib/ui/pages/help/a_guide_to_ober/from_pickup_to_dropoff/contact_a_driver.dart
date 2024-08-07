import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';



class ContactADriver extends StatelessWidget {
  const ContactADriver({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: "Contact a driver"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("",style:StyleConfig.fs24fwBold,),
            Text("",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("",style:StyleConfig.fs24fwBold,),
            Text("",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("",style:StyleConfig.fs24fwBold,),
            Text("",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("",style:StyleConfig.fs24fwBold,),
            Text("",style: StyleConfig.fs14,),
            SizedBox(height: 14,),
            Text("",style:StyleConfig.fs24fwBold,),
            Text("",style: StyleConfig.fs14,),
            SizedBox(height: 14,),


          ],
        ),
      ),
    );
  }
}
