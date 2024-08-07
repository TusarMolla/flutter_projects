/*import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/search_location/add_stop.dart';

class MultiStopPage extends StatelessWidget {
  const MultiStopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
              Container(
                // color: Colors.red,
                height: 46,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Icon(Icons.adjust,size: 24,),
                        Flexible(
                            flex: 1,
                            child: divider()),
                      ],
                    ),
                    Flexible(child: locationField(context,"Start", () { })),
                  ],
                ),
              ),
              Container(
                // color: Colors.blue,
                height: 46,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Flexible(
                          flex: 1,
                            child: divider()),
                        Flexible(
                            flex: 1,child: Icon(Icons.add,size: 24,)),
                        SizedBox(height: 10,)
                      ],
                    ),
                    Flexible(
                        flex: 1,
                        child: locationField(context,"To 2", () {
                          SEORoute.go(context, AddStop());
                        })),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

Widget  divider({height = 10.0}){
    return Container(
      width: 2,
      color: themeTxtColor,
    );
  }

 Widget locationField(BuildContext context,String text,VoidCallback onTap,){
    return Container(
      height: 36,
      margin: EdgeInsets.only(right: 14),

      width: getWidth(context),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8),
      color: ThemeConfig.transparentGrey,
      child: InkWell(
          onTap:()=> onTap(),
          child: SizedBox(
             width: getWidth(context),
              child: Text(text,style: StyleConfig.fs14,))),
    );
  }
}*/
