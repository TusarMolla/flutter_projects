import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/presenters/landing_page_presenter.dart';
import 'package:grostore/screens/landing_pages/page_model.dart';
import 'package:grostore/screens/landing_pages/auth_model.dart';
import 'package:grostore/screens/main.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  void initState() {

   // );
    //show_landing_page.update((p0) => false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
Provider.of<LandingPagePresenter>(context).setContext(context);
Provider.of<LandingPagePresenter>(context).iniState();

    return Consumer<LandingPagePresenter>(
      builder: (context,data,child) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: getHeight(context)*0.88,
                child: CarouselSlider(
                  carouselController:data.controller ,
                  items: data.pages,
                  options: CarouselOptions(
                    autoPlay: false,
                    height: MediaQuery.of(context).size.height,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      data.indexChange(index);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: data.pages.map((page) {
                  int index = data.pages.indexOf(page);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width:data.currentIndex == index? 20:5,
                    height:5,
                    margin:const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(5),
                      color: data.currentIndex == index ? Colors.blue : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                child: Button(
                  shape: StyleConfig.buttonRadius(5.0),
                  color: ThemeConfig.accentColor,
                  padding: EdgeInsets.symmetric(vertical: StyleConfig.padding14),

                  minWidth: getWidth(context),
                onPressed: (){
                    if(data.currentIndex==3)
                    MakeRoute.goName(context, "/main");
                    else
                      data.onChangeSlider();
                },
                child: Text(data.currentIndex==3?AppLang.local(context).skip:AppLang.local(context).next,style: StyleConfig.fs14cWhitefwNormal,),),
              ),
           const  SizedBox(height: 14,)
            ],
          ),
        );
      }
    );
  }
}

