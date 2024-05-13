
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/screens/landing_pages/auth_model.dart';
import 'package:grostore/screens/landing_pages/page_model.dart';

class LandingPagePresenter extends ChangeNotifier{
  int currentIndex = 0;
   List<Widget> pages = [];
  static BuildContext? context;
  CarouselController controller =CarouselController();
  setContext(BuildContext context){
    LandingPagePresenter.context??=context;
  }
  iniState(){
    if(pages.isEmpty) {
      pages.addAll([
        PageModel(
            img: "landing_img1.png",
            headerTxt: AppLang.local(context!)
                .welcome_to_online_fresh_food_grocery_application,
            txt: AppLang.local(context!)
                .energetically_streamline_one_to_one_web_readiness_before_extensive_meta_services),
        PageModel(
            img: "landing_img2.png",
            headerTxt: AppLang.local(context!)
                .welcome_to_online_fresh_food_grocery_application,
            txt: AppLang.local(context!)
                .energetically_streamline_one_to_one_web_readiness_before_extensive_meta_services),
        PageModel(
            img: "landing_img3.png",
            headerTxt: AppLang.local(context!)
                .welcome_to_online_fresh_food_grocery_application,
            txt: AppLang.local(context!)
                .energetically_streamline_one_to_one_web_readiness_before_extensive_meta_services),
       const AuthPageModel(),
      ]);
    }
  }

  indexChange(index){
    currentIndex=index;
    notifyListeners();
  }
  onChangeSlider(){
    controller.nextPage();
    notifyListeners();
  }

}